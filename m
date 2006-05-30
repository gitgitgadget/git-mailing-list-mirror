From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 4/4] Add a basic test case for git send-email, and fix some real bugs discovered.
Date: Tue, 30 May 2006 15:23:30 +0200
Message-ID: <81b0412b0605300623h4f915829yb388c8fdc062c009@mail.gmail.com>
References: <7v8xok3vhj.fsf@assigned-by-dhcp.cox.net>
	 <7v1wuc3t9y.fsf@assigned-by-dhcp.cox.net>
	 <7vu0782e33.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_4353_32629260.1148995410029"
Cc: "Ryan Anderson" <rda@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 30 15:23:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fl4C7-0000Kq-CR
	for gcvg-git@gmane.org; Tue, 30 May 2006 15:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbWE3NXc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 May 2006 09:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWE3NXb
	(ORCPT <rfc822;git-outgoing>); Tue, 30 May 2006 09:23:31 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:31868 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751291AbWE3NXa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 May 2006 09:23:30 -0400
Received: by wr-out-0506.google.com with SMTP id i7so1098287wra
        for <git@vger.kernel.org>; Tue, 30 May 2006 06:23:30 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=EjhkKfaNw4mFoJI1JjbwHqL3a0hnmbf6ymUrJyktbNpDgg26IxQsq+Ip8NdbunZrM8ksPOkiFshxSThahGDEfedH2uG7snUjuao7GPrrKh3doh3rHeJRfMqyMlBwYehPAEqC5P5S0/h/n4sedCca2DDEVQyzdja9C4RqOseOiDM=
Received: by 10.54.77.13 with SMTP id z13mr3180166wra;
        Tue, 30 May 2006 06:23:30 -0700 (PDT)
Received: by 10.54.67.11 with HTTP; Tue, 30 May 2006 06:23:30 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vu0782e33.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21031>

------=_Part_4353_32629260.1148995410029
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -387,7 +387,9 @@ X-Mailer: git-send-email $gitversion
>                 my $pid = open my $sm, '|-';
>                 defined $pid or die $!;
>                 if (!$pid) {
> -                       exec($smtp_server,'-i',@recipients) or die $!;

This construction (perl pipe+fork) will not work on ActiveState Perl
(it does not even parse the construct).
Last time the problem arised it was suggested to replace readers
with "qx{command}". Regretfully there were no writer case back
then. I'd suggest using IPC::Open2 for portability. Like this:

  use IPC::Open2;
  my $fw;
  my $pid = open2(">&1", $fw, "perl", "-w");
  print $fw "exit 0\n";
  close($fw);'

But I wont. It was never portable in windows, no matter how hard
I tried. The best result was getting output from "cat -v", but "cat"
froze afterwards anyway, as "wc" or "perl" did. Besides, it the
command often freezes that poor imitation of xterm windows has.

There is also 2-argument "open" with damn careful quoting,
if anyone cares (dont think anyone does, for windows).
How about disabling the test on cygwin? (patch attached).

------=_Part_4353_32629260.1148995410029
Content-Type: text/plain; name=0001-disable-send-email-test-for-cygwin.txt; 
	charset=ISO-8859-1
Content-Transfer-Encoding: base64
X-Attachment-Id: f_enua70c3
Content-Disposition: attachment; filename="0001-disable-send-email-test-for-cygwin.txt"

LS0tCiB0L3Q5MDAxLXNlbmQtZW1haWwuc2ggfCAgICA3ICsrKysrKysKIDEgZmlsZXMgY2hhbmdl
ZCwgNyBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3QvdDkwMDEt
c2VuZC1lbWFpbC5zaCBiL3QvdDkwMDEtc2VuZC1lbWFpbC5zaAppbmRleCBhNjFkYTFlLi5jM2Ez
NzM3IDEwMDc1NQotLS0gYS90L3Q5MDAxLXNlbmQtZW1haWwuc2gKKysrIGIvdC90OTAwMS1zZW5k
LWVtYWlsLnNoCkBAIC0yNSw2ICsyNSwxMSBAQCB0ZXN0X2V4cGVjdF9zdWNjZXNzIFwKICAgICAg
Z2l0IGFkZCBmYWtlLnNlbmRtYWlsCiAgICAgIEdJVF9BVVRIT1JfTkFNRT0iQSIgZ2l0IGNvbW1p
dCAtYSAtbSAiU2Vjb25kLiInCiAKK2lmIHRlc3QgIiQodW5hbWUgLW8pIiA9IEN5Z3dpbjsgdGhl
bgorICAgIHNheSAiZ2l0LXNlbmQtbWFpbCB0ZXN0cyBkaXNhYmxlZCBvbiBXaW5kb3dzIgorICAg
ICMgYmVjYXVzZSBvZiB3aW5kb3dzIGJlaW5nIHN1Y2ggYSBjcmFwCitlbHNlCisKIHRlc3RfZXhw
ZWN0X3N1Y2Nlc3MgXAogICAgICdFeHRyYWN0IHBhdGNoZXMgYW5kIHNlbmQnIFwKICAgICAnZ2l0
IGZvcm1hdC1wYXRjaCAtbiBIRUFEXjEKQEAgLTM4LDQgKzQzLDYgQEAgdGVzdF9leHBlY3Rfc3Vj
Y2VzcyBcCiAgICAgJ1ZlcmlmeSBjb21tYW5kbGluZScgXAogICAgICdkaWZmIGNvbW1hbmRsaW5l
IGV4cGVjdGVkJwogCitmaQorCiB0ZXN0X2RvbmUKLS0gCjEuMy4zLmc3OTk0Cgo=
------=_Part_4353_32629260.1148995410029--
