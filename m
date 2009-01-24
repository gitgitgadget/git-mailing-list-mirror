From: Benjamin Kramer <benny.kra@googlemail.com>
Subject: Re: [PATCH v2] Makefile: Use libc strlcpy on OSX >= 10.2
Date: Sat, 24 Jan 2009 21:23:33 +0100
Message-ID: <7f978c810901241223n4f7c581av8a687a12b60367fe@mail.gmail.com>
References: <7f978c810901241101h227c5437p88ca7c9cc54abc9a@mail.gmail.com>
	 <7v8wp0o5il.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 24 21:28:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQp7F-0002QS-R5
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 21:28:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755414AbZAXUXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 15:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755028AbZAXUXg
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 15:23:36 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:46978 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491AbZAXUXf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 15:23:35 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2990296fgg.17
        for <git@vger.kernel.org>; Sat, 24 Jan 2009 12:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bgN11sU+vUlZbPc8bjPwke7xfLAio2F9eBudBpK4Y+s=;
        b=T1505ArLIZn6dCigHpWM2bqXa5q4FLOuDTJ7KFkdWzPe4wntugxL7qK8Wuzj6mBMmg
         wV6+le1umSoLVVdMJW55R0z8J6Z6a+Hxmap5DRF35aAYOIWNzF9KBvY4YiaFLEK36gW7
         lQK0E7hvfzgGePgaO0GxdX87XXhmjgthEM4sY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=taGv/VTHMH0m1EHXbN120w72fLWrrMVq5EuySofcLm8fJ4oij/Qfk2cKAVTV+vnKGt
         1c4g69hQLBFBGdjVFht/dcXmEQBLLQcc7w/HrlNa1AC8nOES6b181oAJuCPy7k3hP0Cn
         Rvr0diiNeUOLzAOT925U2IilQ2H4kUxfq4lDA=
Received: by 10.103.106.1 with SMTP id i1mr2146610mum.47.1232828613326; Sat, 
	24 Jan 2009 12:23:33 -0800 (PST)
In-Reply-To: <7v8wp0o5il.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107003>

On Sat, Jan 24, 2009 at 20:42, Junio C Hamano <gitster@pobox.com> wrote:
>
> This existing one says "If 'uname -r' output does not begin with two
> characters '9.' (nine and dot), then set OLD_ICONV".
>
> I am guessing that 'uname -r' says 9.X in "Darwin 9.X" (which is OSX
> 10.5), and existing conditional says that versions before 9.X needs
> OLD_ICONV but later ones do not need it.

Yeah, that's because versions before 10.5 aka darwin 9 aka "Leopard" have a
broken iconv implementation.

> Does 1.X stand for OSX 10.2?  A quick googling finds a handful pages that
> say that OSX 10.2 = Darwin 6.x and OSX 10.3 = Darwin 7.x, and I am not
> sure where you are getting that "begins with one-and-dot" from....

I've got my information from [1]. It says:

darwin 1.3 => OSX 10.0
darwin 1.4 => OSX 10.1
darwin 6 => OSX 10.2
darwin 7 => OSX 10.3
etc.

I don't know why they chose this weird versioning scheme, but wait, it gets
even crazier

darwin 1.4.1 => OSX 10.1
darwin 5.1 => OSX 10.1.1

So my patch checks only for 10.1 but not for 10.1.1 *sigh*

-     NO_STRLCPY = YesPlease
+     ifeq ($(shell expr "$(uname_R)" : '[015]\.'),2)
+             NO_STRLCPY = YesPlease
+     endif

Should get all darwin versions before 6.0 in which strlcpy(3) was
introduced. Thanks for your patience ;)

---------------
[1] http://www.opensource.apple.com/darwinsource/
