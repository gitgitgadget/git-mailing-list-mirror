From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [BUG] Filenames with single colon being treated as remote
 repository
Date: Sun, 21 Apr 2013 09:56:06 -0700
Message-ID: <20130421165606.GA29687@elie.Belkin>
References: <20130421045329.GB30538@WST420>
 <20130421060538.GB10429@elie.Belkin>
 <20130421124511.GA1933@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: William Giokas <1007380@gmail.com>, git@vger.kernel.org,
	fsckdaemon@gmail.com, Daniel Barkalow <barkalow@iabervon.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 21 18:56:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTxYv-0001oc-Cj
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 18:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753761Ab3DUQ4V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 12:56:21 -0400
Received: from mail-da0-f51.google.com ([209.85.210.51]:36614 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753749Ab3DUQ4U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 12:56:20 -0400
Received: by mail-da0-f51.google.com with SMTP id g27so532419dan.38
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 09:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=6wY/PB5BLB7k59U2v6qC6m133RhOnITDGu3J/sDFEgo=;
        b=WXOI0JUywUClZfzQ5FFM31DuvT8nKnji/mNJJMFdcjprWqo2upYU+JHb9dy00a3zbM
         +ZyCj4tZSBrHrFucswxcHmqMPHP9kqx0uTy1a79V0k2LTctbzrqAAgLd/HZCT6uRrsrY
         md1YfUaS4A6TFfEf8o7zPyhfnwrbPYF7qLuomXA1MVFBSthoE1yrKpY+mTI1S252HRi3
         9hfQcx9uKGAhUQzJnh5HUZjwq8BgW2LPHGQCPXIsEJD+gepT/iI5L8EkbpDLZrtbFus1
         rcV1ru80xdAk6A25/9VgC7xZcE5RixPk7NvUbOin5nZ8bwBuQ7jcgnUwiWvmVzSosB1/
         4DxQ==
X-Received: by 10.68.164.33 with SMTP id yn1mr28400016pbb.71.1366563380263;
        Sun, 21 Apr 2013 09:56:20 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id uy3sm21580385pbc.7.2013.04.21.09.56.17
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 09:56:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130421124511.GA1933@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221958>

Jeff King wrote:

> I don't think that is enough. Something like /path/to/foo:bar would
> trigger !is_url already, but then git_connect fails.

Doh.  Here's another try, still untested.

diff --git i/connect.c w/connect.c
index 49e56ba3..fe13942f 100644
--- i/connect.c
+++ w/connect.c
@@ -504,6 +504,7 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 	int c;
 	struct child_process *conn = &no_fork;
 	enum protocol protocol = PROTO_LOCAL;
+	struct stat st;
 	int free_path = 0;
 	char *port = NULL;
 	const char **arg;
@@ -548,7 +549,8 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 		end = host;
 
 	path = strchr(end, c);
-	if (path && !has_dos_drive_prefix(end)) {
+	if (path && !has_dos_drive_prefix(end) &&
+	    (c != ':' || stat(path, &st))) {
 		if (c == ':') {
 			protocol = PROTO_SSH;
 			*path++ = '\0';
