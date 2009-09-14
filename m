From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 2/2] remove NORETURN from function pointers
Date: Mon, 14 Sep 2009 14:32:38 +0200
Message-ID: <40aa078e0909140532q693a7f9qc3d9b1d354cac356@mail.gmail.com>
References: <1252923370-5768-1-git-send-email-kusmabite@gmail.com>
	 <1252923370-5768-2-git-send-email-kusmabite@gmail.com>
	 <20090914105750.GB9216@sigill.intra.peff.net>
	 <40aa078e0909140440x2e189957uf66f36ff29bef302@mail.gmail.com>
	 <20090914120311.GA17172@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 14 14:33:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnAjt-0007p5-SP
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 14:33:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755417AbZINMci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2009 08:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755356AbZINMch
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 08:32:37 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:39658 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755305AbZINMcg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2009 08:32:36 -0400
Received: by bwz19 with SMTP id 19so2036525bwz.37
        for <git@vger.kernel.org>; Mon, 14 Sep 2009 05:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=JD1ILYwXcDvJfhUx6WwKu/vfAHbGxDyXWzdRhphCbFc=;
        b=vW1Zz5Wi4bAsZ95G0aqXa3Dp1jzbleZdYYt6+++58yDFiRqjLZoNp88FKzzqCvdQJ7
         Nj+Xq70A/svRybcvyXWG3E7a2i0p/YIrnQfmIufbGkxOXztrtVsoCxx5hv1ss+BRRPAP
         7XOiWC5ncFrCyO8av1Qg8toRDFGol2ZVOgDSo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=b2WxBZvhCksOn9APWWdkPoLFtJWQonNm+ffAZcJ3oyzYMuDkBAkg6qG/EWACjqmRGg
         NUUlqwlhUluRL3VZL8BSfaBwR94fIPeOsAmQV8r3ZQggqJYkz6MqfL0Km7OLLTXN6/BE
         fYrCGJK3c+UYWcXnURmF/tZYkhcbNqh125o98=
Received: by 10.204.16.88 with SMTP id n24mr5094519bka.52.1252931558656; Mon, 
	14 Sep 2009 05:32:38 -0700 (PDT)
In-Reply-To: <20090914120311.GA17172@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128452>

Compiling the following code gives a warning about unreachable code,
so it's clear that msvc doesn't simply ignore the directive. I'm not
saying that anyone suggested otherwise, I just wanted to know for
sure.

#include <stdio.h>
#include <stdlib.h>
void (*exit_fun)(int) = exit;
void __declspec(noreturn) die(void);
void die(void) { exit_fun(1); }
int main(void) { printf("hello!\n"); die(); printf("world!\n"); }

On Mon, Sep 14, 2009 at 2:03 PM, Jeff King <peff@peff.net> wrote:
> I think I am fine doing it either way. The NORETURN_PTR thing is a bit
> more elegant to me, but that is maybe just my gcc snobiness. We
> shouldn't have to change our code to accomodate MSVC's crappy noreturn
> handling. ;)

First of all, MSVC is not the only compiler that behaves this way. In
fact, GCC the only compiler I've found that behaves this way (but I
must admit, I only tested 4 different compilers, one of which (Comeau)
does not support noreturn at all AFAICT). That behavior might be
crappy, but it's not "MSVC's crappy noreturn handling" - it's
"non-GCC's crappy noreturn handling" :P

The arguments against each solution I see are these:
- abort() gives a run-time error instead of a compile-time warning, so
breakage is trickier to detect (on GCC, which seems to be the target
compiler for the vast majority of git-developers).
- NORETURN_PTR might be bit big of a hammer for a small problem, as it
"pollutes" the whole git source-tree instead of just usage.c.

Anyway, I don't care much what solution we pick. Either should work,
and if someone has strong preference, I'm OK with it.

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
