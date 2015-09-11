From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v8 1/2] submodule refactor: use git_pathdup_submodule()
 in add_submodule_odb()
Date: Fri, 11 Sep 2015 03:53:40 -0400
Message-ID: <20150911075340.GA18917@sigill.intra.peff.net>
References: <1441922231-18270-1-git-send-email-max@max630.net>
 <1441922231-18270-2-git-send-email-max@max630.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Duy Nguyen <pclouds@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Fri Sep 11 09:53:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaJ9Y-0006Bj-3q
	for gcvg-git-2@plane.gmane.org; Fri, 11 Sep 2015 09:53:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023AbbIKHxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 03:53:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:57631 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751956AbbIKHxn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2015 03:53:43 -0400
Received: (qmail 27794 invoked by uid 102); 11 Sep 2015 07:53:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Sep 2015 02:53:43 -0500
Received: (qmail 16995 invoked by uid 107); 11 Sep 2015 07:53:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Sep 2015 03:53:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Sep 2015 03:53:40 -0400
Content-Disposition: inline
In-Reply-To: <1441922231-18270-2-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277652>

On Fri, Sep 11, 2015 at 12:57:10AM +0300, Max Kirillov wrote:

> diff --git a/submodule.c b/submodule.c
> index 245ed4d..7340069 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -119,43 +119,37 @@ void stage_updated_gitmodules(void)
>  
>  static int add_submodule_odb(const char *path)
>  {
> -	struct strbuf objects_directory = STRBUF_INIT;
>  	struct alternate_object_database *alt_odb;
> +	char *objects_directory;

Now that we have strbuf_git_path_submodule(), is there any reason to
switch this away from a strbuf?

That saves us a bunch of strlen calls, and it makes the diff way
shorter. My ulterior motive is that the result also conflicts a lot less
with some patches I'm about to post to harden the malloc and strcpy
calls below.

That would make your patch look something like:

diff --git a/submodule.c b/submodule.c
index 245ed4d..5e5a46f 100644
--- a/submodule.c
+++ b/submodule.c
@@ -122,15 +122,8 @@ static int add_submodule_odb(const char *path)
 	struct strbuf objects_directory = STRBUF_INIT;
 	struct alternate_object_database *alt_odb;
 	int ret = 0;
-	const char *git_dir;
 
-	strbuf_addf(&objects_directory, "%s/.git", path);
-	git_dir = read_gitfile(objects_directory.buf);
-	if (git_dir) {
-		strbuf_reset(&objects_directory);
-		strbuf_addstr(&objects_directory, git_dir);
-	}
-	strbuf_addstr(&objects_directory, "/objects/");
+	strbuf_git_path_submodule(&objects_directory, path, "objects/");
 	if (!is_directory(objects_directory.buf)) {
 		ret = -1;
 		goto done;

-Peff
