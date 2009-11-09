From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2] Show usage string for 'git http-push -h'
Date: Mon, 9 Nov 2009 04:47:34 -0600
Message-ID: <20091109104732.GA15519@progeny.tock>
References: <20080125173149.GA10287@edna.gwendoline.at>
 <20091108071152.GA20741@progeny.tock>
 <20091108072604.GA21367@progeny.tock>
 <be6fef0d0911090052s158ac720ha1fac70da748106d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 11:37:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7Rd6-0002TR-D5
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 11:37:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbZKIKhh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 05:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbZKIKhg
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 05:37:36 -0500
Received: from mail-yw0-f202.google.com ([209.85.211.202]:61873 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbZKIKhf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 05:37:35 -0500
Received: by ywh40 with SMTP id 40so2432654ywh.33
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 02:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=rreqFuPxozbBpgZaSJ3X9Uj5rylBEQ/D1xd4OK6khiY=;
        b=nl+FMfOmaQwj/l4S+9182D2/SKpRy4Wr8WdXdrb+4p5qJ1ZB0z0G7u/UoRfMBc4K/1
         /aVZIHfkw0P8fQG8GSoe+MJ3OiSPdP+9UV/CNfUTehMu4xxB3EWD4oWn+GkCrsfYa7i0
         uC2zrOP9BUa8TONInohHwtPT/Pu8mSxaKhnCo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=leS3mKSy7rGTrmawiWEkYXMlWerembCKXvqdllDocTF05i0x9qOtfdSDasrKDhOYKP
         XkaEvdUf5jPypFoj+/ChGTDGX/GkC92xytXs6Q2+dEKt/ugiCz7P8pM5ueU+//5/qUof
         EPc1cw3+J946kELWQCOw5iCZg0B7XzLNIFVzM=
Received: by 10.150.89.8 with SMTP id m8mr12966357ybb.310.1257763060922;
        Mon, 09 Nov 2009 02:37:40 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 13sm1304242gxk.1.2009.11.09.02.37.39
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 02:37:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <be6fef0d0911090052s158ac720ha1fac70da748106d@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132455>

http-push already knows how to dump usage if it is given no
options, but it interprets '-h' as the URL to a remote
repository:

$ git http-push -h
error: Cannot access URL -h/, return code 6

Dump usage instead.  Humans wanting to pass the URL -h/ to curl
for some reason can use 'git http-push -h/' explicitly.  Scripts
expecting to access an HTTP repository at URL '-h' will break,
though.

Also delay finding a git directory until after option parsing, so
"http-push -h" can be used outside any git repository.

Cc: Tay Ray Chuan <rctay89@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Tay Ray Chuan wrote:

> just curious, I'm wondering why isn't the check for "-h" done in the
> argv loop later on? I see this being done already in the builtins
> diff, log, ls-remote and update-index.

Good question. :)

(I was making sure "git http-push -h" would work without a git
directory by putting the check for -h before setup_git_directory().
But nothing in the argv loop requires a git repository, so it is
better and simpler to move the setup_git_directory() call to after the
loop.  Thanks for the catch.)

> Also, unlike grep, -h <arg> is not an option we're looking out for, so
> I'm not sure if we should allow the user to mix -h with a valid set of
> arguments (which is what Johnathan's patch would allow).

Makes sense.

 http-push.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/http-push.c b/http-push.c
index 00e83dc..ad1a6c9 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1792,8 +1792,6 @@ int main(int argc, char **argv)
 
 	git_extract_argv0_path(argv[0]);
 
-	setup_git_directory();
-
 	repo = xcalloc(sizeof(*repo), 1);
 
 	argv++;
@@ -1827,6 +1825,8 @@ int main(int argc, char **argv)
 				force_delete = 1;
 				continue;
 			}
+			if (!strcmp(arg, "-h"))
+				usage(http_push_usage);
 		}
 		if (!repo->url) {
 			char *path = strstr(arg, "//");
@@ -1854,6 +1854,8 @@ int main(int argc, char **argv)
 	if (delete_branch && nr_refspec != 1)
 		die("You must specify only one branch name when deleting a remote branch");
 
+	setup_git_directory();
+
 	memset(remote_dir_exists, -1, 256);
 
 	/*
-- 
1.6.5.2
