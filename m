From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git-init does not respect existing separate-git-dir
Date: Thu, 29 Aug 2013 10:12:44 -0700
Message-ID: <xmqq38ps775f.fsf@gitster.dls.corp.google.com>
References: <521F40E6.4040102@gmx.com> <20130829130450.GA9323@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ximin Luo <infinity0@gmx.com>, git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 19:12:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF5mB-0008Sg-SZ
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 19:12:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754670Ab3H2RMu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 13:12:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34975 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754369Ab3H2RMt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 13:12:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E0813D23F;
	Thu, 29 Aug 2013 17:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AZ2kC0PiHyLBw5yi62BtQDe18jY=; b=ARGdBq
	dCEZMtZC2SdXU/0FjMOaWN8OmHJkElOTaK6NvLXKT2VPaDs5j9KYOVt9c5iefE2u
	yxSpNj32u95Bbf3qtVb1JuaixLpRZX2Yi9jbzvuAYwL06jJmTFGdNrEPcdTomqZU
	Q3wLV97x4ki2BpQ0re4sBhIA6/Bh1ejJA0wIc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PEPm9RicsW1sEczBPedxOufWGZ4yDAei
	IxudaE/sOc3C1FPD4nl66JT+Cz3WHKsXeunHwqQhD4OTc5ft3HeVjyAN6T8+T4zu
	HUM/r2FuipdKdITLajUjTpa+YfITBLPTCkrsvmt25yHgOiIKtwWcGcBgnB8nm4au
	mMzfSn+qyiU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 518233D23E;
	Thu, 29 Aug 2013 17:12:48 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9EBFF3D23D;
	Thu, 29 Aug 2013 17:12:46 +0000 (UTC)
In-Reply-To: <20130829130450.GA9323@lanh> (Duy Nguyen's message of "Thu, 29
	Aug 2013 20:04:50 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3A2D0F2A-10CE-11E3-A37B-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233286>

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Aug 29, 2013 at 01:39:02PM +0100, Ximin Luo wrote:
>> It should not be necessary to re-specify --separate-git-dir when re-initialising a git repo.
>> 
>> $ git init --separate-git-dir ../repo
>> Initialized empty Git repository in /home/infinity0/tmp/repo/
>> 
>> $ git init
>> /home/infinity0/tmp/wtree/.git/refs: Not a directory
>> 1
>
> This patch seems to work. Lightly tested.
>
> -- 8< --
> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index 78aa387..d0e5b2e 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -192,6 +192,15 @@ static int create_default_files(const char *template_path)
>  		die(_("insane git directory %s"), git_dir);
>  	memcpy(path, git_dir, len);
>  
> +	if (!lstat(path, &st1) && S_ISREG(st1.st_mode)) {
> +		git_dir = read_gitfile(git_dir);
> +		len = strlen(git_dir);
> +		if (len > sizeof(path)-50)
> +			die(_("insane git directory %s"), git_dir);
> +		set_git_dir(git_dir);

This repetition from the pre-context of the patch makes me wonder if
it may be a better solution to make sure we have already resolved
the gitfile way before we get here, so that get_git_dir() gives the
real location.

The codepaths in init and clone are both special in that they may be
dealing with a new repository and because of that, they may need to
call set_git_dir() themselves, but in the codeflow for normal (read:
those who deal with an existing repositories) programs, discovery of
the real ".git" directory is done by environment.c::get_git_dir(),
which to calls setup_git_env(), which in turn read_gitfile()'s on
".git" when using the default ".git", like so:

    static void setup_git_env(void)
    {
            git_dir = getenv(GIT_DIR_ENVIRONMENT);
            git_dir = git_dir ? xstrdup(git_dir) : NULL;
            if (!git_dir) {
                    git_dir = read_gitfile(DEFAULT_GIT_DIR_ENVIRONMENT);
                    git_dir = git_dir ? xstrdup(git_dir) : NULL;
            }
            if (!git_dir)
                    git_dir = DEFAULT_GIT_DIR_ENVIRONMENT;

And after this sequence, git_object_dir and git_index_file are
computed off of git_dir, unless they are specified to use an
alternate location via environment variables.

I wonder if the last "use DEFAULT_GIT_DIR_ENVIRONMENT" (which is
".git") should also do the read_gitfile() thing, perhaps like this
(totally untested):

 environment.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/environment.c b/environment.c
index 5398c36..944e10e 100644
--- a/environment.c
+++ b/environment.c
@@ -123,14 +123,16 @@ static char *expand_namespace(const char *raw_namespace)
 
 static void setup_git_env(void)
 {
+	const char *gitfile;
+
 	git_dir = getenv(GIT_DIR_ENVIRONMENT);
-	git_dir = git_dir ? xstrdup(git_dir) : NULL;
-	if (!git_dir) {
-		git_dir = read_gitfile(DEFAULT_GIT_DIR_ENVIRONMENT);
-		git_dir = git_dir ? xstrdup(git_dir) : NULL;
-	}
 	if (!git_dir)
 		git_dir = DEFAULT_GIT_DIR_ENVIRONMENT;
+	gitfile = read_gitfile(git_dir);
+	if (!gitfile)
+		git_dir = xstrdup(git_dir);
+	else
+		git_dir = gitfile;
 	git_object_dir = getenv(DB_ENVIRONMENT);
 	if (!git_object_dir) {
 		git_object_dir = xmalloc(strlen(git_dir) + 9);
