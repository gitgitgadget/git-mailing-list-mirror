From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git: make was_alias and done_help non-static
Date: Mon, 2 Mar 2015 15:29:18 -0500
Message-ID: <20150302202918.GA22211@peff.net>
References: <1425297757-16431-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 21:29:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSWy2-0006ed-Fl
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 21:29:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753851AbbCBU3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 15:29:21 -0500
Received: from cloud.peff.net ([50.56.180.127]:55080 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753447AbbCBU3V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2015 15:29:21 -0500
Received: (qmail 22809 invoked by uid 102); 2 Mar 2015 20:29:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Mar 2015 14:29:20 -0600
Received: (qmail 9759 invoked by uid 107); 2 Mar 2015 20:29:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Mar 2015 15:29:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Mar 2015 15:29:18 -0500
Content-Disposition: inline
In-Reply-To: <1425297757-16431-1-git-send-email-kuleshovmail@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264621>

On Mon, Mar 02, 2015 at 06:02:37PM +0600, Alexander Kuleshov wrote:

> 'was_alias' variable does not need to store it's value on each
> iteration in the loop, anyway this variable changes it's value with run_argv.
> 
> 'done_help' variable does not need to be static variable too if we'll move it
> out the loop.
> 
> So these variables do not need to be static.

Agreed, but...

> diff --git a/git.c b/git.c
> index 1780233..96723b8 100644
> --- a/git.c
> +++ b/git.c
> @@ -619,6 +619,7 @@ int main(int argc, char **av)
>  {
>  	const char **argv = (const char **) av;
>  	const char *cmd;
> +	int done_help, was_alias;

Now done_help is not initialized, but we read from it before assigning
it. And I think there is no need for was_alias to go outside the loop,
right?

>  	startup_info = &git_startup_info;
>  
> @@ -681,8 +682,6 @@ int main(int argc, char **av)
>  	setup_path();
>  
>  	while (1) {
> -		static int done_help = 0;
> -		static int was_alias = 0;
>  		was_alias = run_argv(&argc, &argv);

Dropping the initialization of was_alias is fine, since we always assign
to it before reading. That becomes more obvious if we leave it in the
loop, and we can even assign in its declaration.

So all together, like:

diff --git a/git.c b/git.c
index acde36a..8dbe12f 100644
--- a/git.c
+++ b/git.c
@@ -635,6 +635,7 @@ int main(int argc, char **av)
 {
 	const char **argv = (const char **) av;
 	const char *cmd;
+	int done_help = 0;
 
 	startup_info = &git_startup_info;
 
@@ -697,9 +698,7 @@ int main(int argc, char **av)
 	setup_path();
 
 	while (1) {
-		static int done_help = 0;
-		static int was_alias = 0;
-		was_alias = run_argv(&argc, &argv);
+		int was_alias = run_argv(&argc, &argv);
 		if (errno != ENOENT)
 			break;
 		if (was_alias) {
