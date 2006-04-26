From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] send-email: Change from Mail::Sendmail to Net::SMTP
Date: Wed, 26 Apr 2006 12:45:41 +1200
Message-ID: <46a038f90604251745u1b15ad99ka1aeff1cd8d8c344@mail.gmail.com>
References: <20060325235859.GO26071@mythryan2.michonline.com>
	 <1143336048205-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Junio C Hamano" <junkio@cox.net>, git <git@vger.kernel.org>,
	"Ryan Anderson" <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Wed Apr 26 02:45:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYYA8-0006nc-4k
	for gcvg-git@gmane.org; Wed, 26 Apr 2006 02:45:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbWDZApn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 20:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWDZApn
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 20:45:43 -0400
Received: from wproxy.gmail.com ([64.233.184.229]:14952 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932317AbWDZApm convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Apr 2006 20:45:42 -0400
Received: by wproxy.gmail.com with SMTP id i2so476801wra
        for <git@vger.kernel.org>; Tue, 25 Apr 2006 17:45:41 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eskXmmgBPcx06qyLa/jUE6C1SI0cBQuLPxns6ukXB17Qhvmi3/uSVkb/ygGrtj8k9yF9Klh3g1WJfOCB1VQPQt+zhN/2H9jjQSIU6/OclExkUp8RNIyqy/tI4rm7zmJWGi+w/BEgxtYPV79Q3gB2l2xi+71xYgUTXVWWDtytm+k=
Received: by 10.54.114.2 with SMTP id m2mr155029wrc;
        Tue, 25 Apr 2006 17:45:41 -0700 (PDT)
Received: by 10.54.127.4 with HTTP; Tue, 25 Apr 2006 17:45:41 -0700 (PDT)
To: "Eric Wong" <normalperson@yhbt.net>
In-Reply-To: <1143336048205-git-send-email-normalperson@yhbt.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19181>

On 3/26/06, Eric Wong <normalperson@yhbt.net> wrote:
> Net::SMTP is in the base Perl distribution, so users are more
> likely to have it.  Net::SMTP also allows reusing the SMTP
> connection, so sending multiple emails is faster.

This is causing problems for me on my Debian sarge dev box.

 * If I have to believe strace(), Net::SMTP is trying to look up
"localhost" via DNS. Sketchy workaround: use 127.0.0.1.

 * This box has nothing listening on port 25. It doesn't get email
from the net, being a LAN machine, so I've told the debian config
system that we don't need an smtp daemon. Net::SMTP doesn't know how
to use /usr/bin/sendmail

 * That nasty @@VERSION@@ thing isn't valid perl, so working on this
code is a pain. Something like this (warning! broken diff ahead!)
fixes it for me.

@@ -292,6 +292,11 @@ sub send_message
        @recipients = unique_email_list(@recipients,@cc);
        my $date = strftime('%a, %d %b %Y %H:%M:%S %z', localtime($time++));

+       my $gitversion = '@@GIT_VERSION@@';
+       if ($gitversion eq '@@'.'GIT_VERSION@@') {
+           $gitversion = `git --version`;
+       }
+
        my $header = "From: $from
 To: $to
 Cc: $cc
@@ -299,11 +304,11 @@ Subject: $subject
 Reply-To: $from
 Date: $date
 Message-Id: $message_id
-X-Mailer: git-send-email @@GIT_VERSION@@
+X-Mailer: git-send-email $gitversion
 ";
        $header .= "In-Reply-To: $reply_to\n" if $reply_to;

cheers,


martin
