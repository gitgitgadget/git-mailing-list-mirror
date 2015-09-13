From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH v8 1/2] submodule refactor: use git_pathdup_submodule()
 in add_submodule_odb()
Date: Mon, 14 Sep 2015 01:26:29 +0300
Message-ID: <20150913222619.GA8042@wheezy.local>
References: <1441922231-18270-1-git-send-email-max@max630.net>
 <1441922231-18270-2-git-send-email-max@max630.net>
 <20150911075340.GA18917@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Max Kirillov <max@max630.net>, Jens Lehmann <Jens.Lehmann@web.de>,
	Duy Nguyen <pclouds@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 14 00:26:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbFjO-0006tA-KO
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 00:26:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752493AbbIMW0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2015 18:26:38 -0400
Received: from p3plsmtpa11-04.prod.phx3.secureserver.net ([68.178.252.105]:56172
	"EHLO p3plsmtpa11-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752396AbbIMW0h (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Sep 2015 18:26:37 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa11-04.prod.phx3.secureserver.net with 
	id GmSU1r00C5B68XE01mSaml; Sun, 13 Sep 2015 15:26:37 -0700
Content-Disposition: inline
In-Reply-To: <20150911075340.GA18917@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277799>

On Fri, Sep 11, 2015 at 03:53:40AM -0400, Jeff King wrote:
> 
> Now that we have strbuf_git_path_submodule(), is there any reason to
> switch this away from a strbuf?
> 
> That saves us a bunch of strlen calls, and it makes the diff way
> shorter. My ulterior motive is that the result also conflicts a lot less
> with some patches I'm about to post to harden the malloc and strcpy
> calls below.
> 
> That would make your patch look something like:
> 
> diff --git a/submodule.c b/submodule.c
> index 245ed4d..5e5a46f 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -122,15 +122,8 @@ static int add_submodule_odb(const char *path)
>  	struct strbuf objects_directory = STRBUF_INIT;
>  	struct alternate_object_database *alt_odb;
>  	int ret = 0;
> -	const char *git_dir;
>  
> -	strbuf_addf(&objects_directory, "%s/.git", path);
> -	git_dir = read_gitfile(objects_directory.buf);
> -	if (git_dir) {
> -		strbuf_reset(&objects_directory);
> -		strbuf_addstr(&objects_directory, git_dir);
> -	}
> -	strbuf_addstr(&objects_directory, "/objects/");
> +	strbuf_git_path_submodule(&objects_directory, path, "objects/");
>  	if (!is_directory(objects_directory.buf)) {
>  		ret = -1;
>  		goto done;
> 
> -Peff

Thank you. This is how it looks now.

-- 
Max
