From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: Date parsing
Date: Sat, 21 Jun 2008 23:52:40 +0200
Message-ID: <20080621215240.GD15111@leksak.fem-net>
References: <bd6139dc0806100758xb41d08dh18e3051088b707e5@mail.gmail.com> <Zx2uvEYSssjj9E0HrmUL8wYASyWX9L9w8LkR-gGRAmnD9isjoEeyKg@cipher.nrlssc.navy.mil> <bd6139dc0806100831y7a00a0f4sbc8dee9df7a8c16a@mail.gmail.com> <alpine.LFD.1.10.0806100942500.3101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sverre@rabbelier.nl, Brandon Casey <casey@nrlssc.navy.mil>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jun 21 23:54:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAB24-0008Lg-QI
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 23:54:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202AbYFUVxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 17:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752103AbYFUVxH
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 17:53:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:39471 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751950AbYFUVxG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2008 17:53:06 -0400
Received: (qmail invoked by alias); 21 Jun 2008 21:52:54 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp029) with SMTP; 21 Jun 2008 23:52:54 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+/uwojDc6/J9OjvgRmQcQVU+Xh6ySI0IBHiHQwYf
	WfxyGTccF4zPrz
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KAB0i-0001QS-E8; Sat, 21 Jun 2008 23:52:40 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0806100942500.3101@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85732>

Hi,

> > On Tue, Jun 10, 2008 at 5:10 PM, Brandon Casey <casey@nrlssc.navy.mil> wrote:
> > > Take a look at match_multi_number in date.c
> > > European ordering is preferred when the separator is '.'
> > 
> > Ok, then I'll use . in the future, that's nice :).
> 
> Well, there are safer ways to give the date.
> 
> If you do it in strict rfc822 format, you'll never have any confusion 
> what-so-ever. The "approxidate()" thing tries to parse any random input, 
> but it *is* meant to be excessively liberal.

Today I've been playing around with approxidate(), too, and I think I
found some bug in date parsing. I let copy&paste speak...

Correct:

$ ./test-date "2008-07-01 23:59:59 +0200"
2008-07-01 23:59:59 +0200 -> 1214949599 +0200 -> Tue Jul  1 23:59:59 2008
2008-07-01 23:59:59 +0200 -> Tue Jul  1 23:59:59 2008

And even:

$ ./test-date "2008-07-01 24:00:00 +0200"
2008-07-01 24:00:00 +0200 -> 1214949600 +0200 -> Wed Jul  2 00:00:00 2008
2008-07-01 24:00:00 +0200 -> Wed Jul  2 00:00:00 2008

But then there's a jump in time:

$ ./test-date "2008-07-02 00:00:00 +0200"
2008-07-02 00:00:00 +0200 -> 1202335200 +0200 -> Wed Feb  6 23:00:00 2008
2008-07-02 00:00:00 +0200 -> Wed Feb  6 23:00:00 2008

$ ./test-date "2008-07-02 01:00:00 +0200"
2008-07-02 01:00:00 +0200 -> 1202338800 +0200 -> Thu Feb  7 00:00:00 2008
2008-07-02 01:00:00 +0200 -> Thu Feb  7 00:00:00 2008


If we let test-date just print the timestamp...

diff --git a/test-date.c b/test-date.c
index 62e8f23..18d53c1 100644
--- a/test-date.c
+++ b/test-date.c
@@ -11,10 +11,10 @@ int main(int argc, char **argv)
 		memcpy(result, "bad", 4);
 		parse_date(argv[i], result, sizeof(result));
 		t = strtoul(result, NULL, 0);
-		printf("%s -> %s -> %s", argv[i], result, ctime(&t));
+		printf("%s -> %lu\n", argv[i], t);
 
 		t = approxidate(argv[i]);
-		printf("%s -> %s\n", argv[i], ctime(&t));
+		printf("%s -> %lu\n", argv[i], t);
 	}
 	return 0;
 }
-- -- -- --

... then we get:

$ ./test-date "2008-07-01 23:59:59 +0200"
2008-07-01 23:59:59 +0200 -> 1214949599
2008-07-01 23:59:59 +0200 -> 1214949599

$ ./test-date "2008-07-02 00:00:00 +0200"
2008-07-02 00:00:00 +0200 -> 1202335200
2008-07-02 00:00:00 +0200 -> 1202335200

Also, with another timezone, we get:

$ ./test-date "2008-07-01 23:59:59 +0000"
2008-07-01 23:59:59 +0000 -> 1214956799
2008-07-01 23:59:59 +0000 -> 1214956799

$ ./test-date "2008-07-02 00:00:00 +0000"
2008-07-02 00:00:00 +0000 -> 1202342400
2008-07-02 00:00:00 +0000 -> 1202342400

Is something wrong in my format or is there a bug?

Providing timestamps works, of course ;-)

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
