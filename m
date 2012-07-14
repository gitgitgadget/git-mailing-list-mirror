From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH maint-1.6.5] block-sha1: avoid unaligned accesses on some
 big-endian systems
Date: Sat, 14 Jul 2012 12:11:59 -0700
Message-ID: <CA+55aFy+y=TCoJUQarinaduibt4i-46TAuvpp7fsAmjDZj_+3w@mail.gmail.com>
References: <20120713233957.6928.87541.reportbug@electro.phys.waikato.ac.nz>
 <20120714002950.GA3159@burratino> <5000CBCA.8020607@orcon.net.nz>
 <20120714021856.GA3062@burratino> <50010B84.5030606@orcon.net.nz> <20120714075906.GD3693@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Cree <mcree@orcon.net.nz>, git@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 14 21:13:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sq7m3-000385-Ct
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jul 2012 21:13:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583Ab2GNTMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jul 2012 15:12:22 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:58111 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361Ab2GNTMU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2012 15:12:20 -0400
Received: by weyx8 with SMTP id x8so3167368wey.19
        for <git@vger.kernel.org>; Sat, 14 Jul 2012 12:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=cOoZe467X1/6B1kn0pi/c9XekPcdejIAklJL9KRymow=;
        b=kLmhBAcsSzKepG7/eQa+WT0vS1BvOZVxXJ5SAZQRsvdcF4tBZtduGLafGrWKGVdbW9
         sKjFe2Fyq0YHmZvAnoogbp6cskHcpAuEqahT18lYv/XwxYBIy3fsZeL1sAKYRiQOoJND
         3xqFxPMVivbfkxPuT7XVSJen6jeGClZoBBJ3qp7xgvLrDDT5w1yBrnGjmiSqeVXtkxER
         WXQemUR9tU1EgwOUSl/ho4JbCbnG/gZtYRg8Ap7moAlbpLK0lzSdQLTIbhHwh8lcixtR
         tGJiwRKP5dT+mrfnpfDWbNIWchEUNrZ1NGtw2Weu6y9cd/87pyXKfbV6/kv3hTEuQk0O
         S8Hg==
Received: by 10.180.100.35 with SMTP id ev3mr6803146wib.10.1342293139236; Sat,
 14 Jul 2012 12:12:19 -0700 (PDT)
Received: by 10.216.142.14 with HTTP; Sat, 14 Jul 2012 12:11:59 -0700 (PDT)
In-Reply-To: <20120714075906.GD3693@burratino>
X-Google-Sender-Auth: XSYJtZffmqxDzWLt1u4Z6qwAMEI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201448>

On Sat, Jul 14, 2012 at 12:59 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Unfortunately, on big-endian architectures, if p is a pointer to
> unsigned int then current gcc assumes it is properly aligned and
> converts this construct to a 32-bit load.

This patch seems to entirely depend on the location of the cast. And
as far as I can tell, that workaround will in turn depend on just what
gets inlined.

My gut feel is that this makes the code uglier (the manual "multiply
by four" being a prime example) while not really even addressing the
problem.

I think a much better approach would be to just mark the unsigned int
data pointer as being unaligned, or add a "get_unaligned()" helper
function (you have to do a structure member and mark the structure
packed, I think - I don't think you can just mark an int pointer
packed). Sure, that's compiler-dependent, but if a compiler does
something like gcc apparently does, it had better support the notion
of unaligned pointers.

And then gcc might actually do the unaligned word read *optimally* on
big-endian architectures, instead of that idiotic byte-at-a-time crap
with shifting.

Anyway, the whole "noticed on alpha" makes no sense, since alpha isn't
even big-endian. So the commit log is insane and misleading too. Alpha
is very much little-endian, but maybe gcc turns the thing into an
unaligned load followed by a bswap.

                      Linus
