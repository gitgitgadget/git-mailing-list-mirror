Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA06B20451
	for <e@80x24.org>; Wed, 14 Dec 2016 00:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752728AbcLNAJI (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 19:09:08 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55410 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751694AbcLNAJG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 19:09:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AB4A856B1E;
        Tue, 13 Dec 2016 19:08:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nCRkk/NgiqBeCviHX+uIAsvNyKM=; b=vs9nyV
        83mTwm6QN8Dxt/9eJ0fs+Bpea/tO+39woDDblv7gxYqxOJPHxhFZyZ43AG1voZOL
        9hS441HY4UJFxyyANOl0x6ua0ADKxdpAjqHTmenfIejdxly0qxbc1uX1EfoI6Ehn
        iEZxMPpHC5xQutWp+4bmn0YYzYBcPab+v1SDI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kQN3ZET2B7tdXCO+C76aritbhVrYhSnD
        5phED9q/4dJErKMZ1NvoXAgKxIVeV9DovrwCpTBf5sbxt8osAtoSJq9JKle2G2ey
        fNbfKCqRxILKx9uqTT36QxNV9A0a91I59yII4SnZYSd+xVrjKbZUf16iIaUfagpj
        hwvVtk3Umpk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A17B656B1D;
        Tue, 13 Dec 2016 19:08:42 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2040256B1C;
        Tue, 13 Dec 2016 19:08:42 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Diamand <luke@diamand.org>
Cc:     git@vger.kernel.org, viniciusalexandre@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCHv3] git-p4: support git worktrees
References: <20161213215128.20288-1-luke@diamand.org>
        <20161213215128.20288-2-luke@diamand.org>
Date:   Tue, 13 Dec 2016 16:08:40 -0800
In-Reply-To: <20161213215128.20288-2-luke@diamand.org> (Luke Diamand's message
        of "Tue, 13 Dec 2016 21:51:28 +0000")
Message-ID: <xmqqlgvjz81j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 78BD488C-C191-11E6-8F70-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luke Diamand <luke@diamand.org> writes:

> git-p4 would attempt to find the git directory using
> its own specific code, which did not know about git
> worktrees.
>
> Rework it to use "git rev-parse --git-dir" instead.
>
> Add test cases for worktree usage and specifying
> git directory via --git-dir and $GIT_DIR.
>
> Signed-off-by: Luke Diamand <luke@diamand.org>
> ---
>  git-p4.py                 | 17 +++++++++++++----
>  t/t9800-git-p4-basic.sh   | 20 ++++++++++++++++++++
>  t/t9806-git-p4-options.sh | 32 ++++++++++++++++++++++++++++++++
>  3 files changed, 65 insertions(+), 4 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index fd5ca52..6a1f65f 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -85,6 +85,16 @@ def p4_build_cmd(cmd):
>          real_cmd += cmd
>      return real_cmd
>  
> +def git_dir(path):
> +    """ Return TRUE if the given path is a git directory (/path/to/dir/.git).
> +        This won't automatically add ".git" to a directory.
> +    """
> +    d = read_pipe(["git", "--git-dir", path, "rev-parse", "--git-dir"], True).strip()
> +    if not d or len(d) == 0:
> +        return None
> +    else:
> +        return d
> +
>  def chdir(path, is_client_path=False):
>      """Do chdir to the given path, and set the PWD environment
>         variable for use by P4.  It does not look at getcwd() output.
> @@ -563,10 +573,7 @@ def currentGitBranch():
>          return read_pipe(["git", "name-rev", "HEAD"]).split(" ")[1].strip()
>  
>  def isValidGitDir(path):
> -    if (os.path.exists(path + "/HEAD")
> -        and os.path.exists(path + "/refs") and os.path.exists(path + "/objects")):
> -        return True;
> -    return False
> +    return git_dir(path) != None
>  
>  def parseRevision(ref):
>      return read_pipe("git rev-parse %s" % ref).strip()
> @@ -3682,6 +3689,7 @@ def main():
>          if cmd.gitdir == None:
>              cmd.gitdir = os.path.abspath(".git")
>              if not isValidGitDir(cmd.gitdir):
> +                # "rev-parse --git-dir" without arguments will try $PWD/.git
>                  cmd.gitdir = read_pipe("git rev-parse --git-dir").strip()
>                  if os.path.exists(cmd.gitdir):
>                      cdup = read_pipe("git rev-parse --show-cdup").strip()
> @@ -3694,6 +3702,7 @@ def main():
>              else:
>                  die("fatal: cannot locate git repository at %s" % cmd.gitdir)
>  
> +        # so git commands invoked from the P4 workspace will succeed
>          os.environ["GIT_DIR"] = cmd.gitdir

The real fix has become surprisingly short and "feels right".

Will queue. Thanks.

