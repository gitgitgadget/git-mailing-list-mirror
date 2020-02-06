Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4485DC35247
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 19:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1999721927
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 19:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kE5MS4mo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgBFTmU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 14:42:20 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57681 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbgBFTmU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Feb 2020 14:42:20 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CE7134CF8D;
        Thu,  6 Feb 2020 14:42:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PRZzjay3ZMZydcmkDJLM5d4yjrI=; b=kE5MS4
        moW6n8CouPoUmJ9I0zTH/2y/lPLwsjeRRXWPLAkisk/kERtNpEiCx+GN/fclRjvX
        tU/ry+wabhsksAYEbArOdYjypYt1JAw/VyqeMk1Gz2XgwoXV36KbyPHtVsmB8VLc
        LNTEX+frfubUAcjDAnNDaRIOhTDgy+DEvEiWc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GyM72rSL3sEv+tmfopj1RW48qN9BOWgi
        kvjpcY2Cbdlh5S/SoxAHE8bxXVTZG/cVpm01vngNy4yITYOqus/hx1LEfaz/3dsy
        IczBqSeWvWG6NQCAQ2gelNwp1Ja/bpKhF3vLyloNq4Ey05CI1dBJPqHts3ODSmHh
        ZZTfBvfg/WE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C5CDA4CF8C;
        Thu,  6 Feb 2020 14:42:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 303254CF8B;
        Thu,  6 Feb 2020 14:42:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ben Keene <seraphire@gmail.com>
Subject: Re: [PATCH v3 2/5] git-p4: create new function run_git_hook
References: <pull.698.v2.git.git.1580507895.gitgitgadget@gmail.com>
        <pull.698.v3.git.git.1581002149.gitgitgadget@gmail.com>
        <85918a7edb6482cc1c555917075f8cfd2f18ba32.1581002149.git.gitgitgadget@gmail.com>
Date:   Thu, 06 Feb 2020 11:42:16 -0800
In-Reply-To: <85918a7edb6482cc1c555917075f8cfd2f18ba32.1581002149.git.gitgitgadget@gmail.com>
        (Ben Keene via GitGitGadget's message of "Thu, 06 Feb 2020 15:15:45
        +0000")
Message-ID: <xmqqo8ubec4n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C8073F3A-4918-11EA-8C03-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +def run_git_hook(cmd, param=[]):
> +    """Execute a hook if the hook exists."""
> +    if verbose:
> +        sys.stderr.write("Looking for hook: %s\n" % cmd)
> +        sys.stderr.flush()
> +
> +    hooks_path = gitConfig("core.hooksPath")
> +    if len(hooks_path) <= 0:
> +        hooks_path = os.path.join(os.environ.get("GIT_DIR", ".git"), "hooks")

Using the .get() with default is misleading, I think (see an earlier reply).

> +    if not isinstance(param, list):
> +        param=[param]
> +
> +    # resolve hook file name, OS depdenent
> +    hook_file = os.path.join(hooks_path, cmd)
> +    if platform.system() == 'Windows':
> +        if not os.path.isfile(hook_file):
> +            # look for the file with an extension
> +            files = glob.glob(hook_file + ".*")
> +            if not files:
> +                return True
> +            files.sort()
> +            hook_file = files[0]
> +
> +    if not os.path.isfile(hook_file) or not os.access(hook_file, os.X_OK):
> +        return True
> +
> +    return run_hook_command(hook_file, param) == 0
> +
> +def run_hook_command(cmd, param):
> +    """Executes a git hook command
> +       cmd = the command line file to be executed. This can be
> +       a file that is run by OS association.
> +
> +       param = a list of parameters to pass to the cmd command
> +
> +       On windows, the extension is checked to see if it should
> +       be run with the Git for Windows Bash shell.  If there
> +       is no file extension, the file is deemed a bash shell
> +       and will be handed off to sh.exe. Otherwise, Windows
> +       will be called with the shell to handle the file assocation.
> +
> +       For non Windows operating systems, the file is called
> +       as an executable.
> +    """
> +    cli = [cmd] + param
> +    use_shell = False
> +    if platform.system() == 'Windows':
> +        (root,ext) = os.path.splitext(cmd)
> +        if ext == "":
> +            exe_path = os.environ.get("EXEPATH")
> +            if exe_path is None:
> +                exe_path = ""
> +            else:
> +                exe_path = os.path.join(exe_path, "bin")
> +            cli = [os.path.join(exe_path, "SH.EXE")] + cli
> +        else:
> +            use_shell = True

Please ask somebody familiar with Windows to review this "if
Windows" and the other one in run_git_hook().

> +    return subprocess.call(cli, shell=use_shell)
> +
> +
>  def write_pipe(c, stdin):
>      if verbose:
>          sys.stderr.write('Writing pipe: %s\n' % str(c))
> @@ -4125,7 +4187,6 @@ def printUsage(commands):
>      "unshelve" : P4Unshelve,
>  }
>  
> -
>  def main():
>      if len(sys.argv[1:]) == 0:
>          printUsage(commands.keys())
