From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH] daemon: restore getpeername(0,...) use
Date: Mon, 10 Sep 2012 20:27:07 +0200
Message-ID: <004901cd8f81$e2bb20c0$a8316240$@schmitz-digital.de>
References: <1347124173-14460-1-git-send-email-jengelh@inai.de> <1347124173-14460-2-git-send-email-jengelh@inai.de> <7v1uicuyqi.fsf@alter.siamese.dyndns.org> <alpine.LNX.2.01.1209082119320.18369@frira.zrqbmnf.qr> <20120910142100.GB7906@sigill.intra.peff.net> <k2ku26$jld$1@ger.gmane.org> <20120910155006.GA8737@sigill.intra.peff.net> <k2l7s5$gl9$1@ger.gmane.org> <20120910175846.GA16791@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "'Jeff King'" <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 10 20:27:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB8hk-0003xS-HT
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 20:27:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757676Ab2IJS1U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 14:27:20 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:57807 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757549Ab2IJS1T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Sep 2012 14:27:19 -0400
Received: from DualCore (dsdf-4db54003.pool.mediaWays.net [77.181.64.3])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0M8X0Z-1TX3Qk2UpH-00wEel; Mon, 10 Sep 2012 20:27:09 +0200
In-Reply-To: <20120910175846.GA16791@sigill.intra.peff.net>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQKQODjfGir0QdY292QjkJfxRd4QjQGLm4FOAfJHphkCW20PcQG3yVbKAc6oVAgCf8V3SgGEoKCJAUZLKbyViTk3gA==
Content-Language: de
X-Provags-ID: V02:K0:Is83H68WbCU38JqBB2Xn/5REzzd1sZU2iq4SBZb6T21
 taajsCQibI9bGssVLvowNZIJ2xWKMbbWisF5M/y/U9n7iLceLm
 cl+CQEpbxkmOiP3QOxyQReB7ystAex/GwSHTnfzv2EYDseuLmD
 DXMICuXELfRvWdhBu+jykVrxBNDIbBed0GiQOWHrCxAlp/ju2W
 klXV4thCNLnjuUWufPED6OERR/8Ck612IZwcrlkwy2wQ9ISjef
 B8SUyo/z44vlWXam5GbBBv8LJAiDxq/ehiWYEZ42n9aaemg8Jp
 AOxI7/meSV+RZ4cvOGvK0RdzgJs4J3u/Se7OvsuL51N6MlqdH2
 Vcd9g6mw7ofU/d9Blqh5wS4n2j8qHU/5wY/FF1FrL3CrFRwtLq
 t+jDQw/x7ue3Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205158>

> From: Jeff King [mailto:peff@peff.net]
> Sent: Monday, September 10, 2012 7:59 PM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org
> Subject: Re: [PATCH] daemon: restore getpeername(0,...) use
> 
> On Mon, Sep 10, 2012 at 07:26:26PM +0200, Joachim Schmitz wrote:
> 
> > >>as are non-const array intializers, e.g.:
> > >>
> > >>               const char *args[] = { editor, path, NULL };
> > >>                                              ^
> > >>".../git/editor.c", line 39: error(122): expression must have a
> > >>constant value
> > >>
> > >>So git source is not plain C89 code (anymore?)
> > >
> > >I remember we excised a whole bunch of non-constant initializers at
> > >some point because somebody's compiler was complaining. But I suppose
> > >this one has slipped back in, because non-constant initializers are
> > >so damn useful. And nobody has complained, which I imagine means
> > >nobody has bothered building lately on those older systems that
> > >complained.
> >
> > OK, record my complaint then ;-)
> 
> Oops, did I say "complained"? I meant "sent patches". Hint, hint. :)

Oops ;-)
 
> > At least some older release of HP NonStop only have C89 and are still in use
> >
> > And tying to compile in plain C89 mode revealed several other
> > problems too (e.g. size_t seems not to be typedef'd?)
> 
> I think it is a mistake to set -std=c89 (or whatever similar option your
> compiler supports). Like I said, we are not interested in being strictly
> C89-compliant. We are interested in working on real-world systems.
> 
> If your compiler complains in the default mode (or when it is given some
> reasonable practical settings), then that's something worth fixing. But
> if your compiler is perfectly capable of compiling git, but you choose
> to cripple it by telling it to be pedantic about a standard, then that
> is not git's problem at all.

Older version of HP NonStop only have a c89 compiler, newer have a -Wc99lite switch to that, which enables some C99 features and the latest additionally have a c99 compiler. There's no switch to cripple something, it is just a fact that older systems don't have c99 or only limited support for it. A whole series of machines (which is still in use!) cannot get upgraded to anything better than c89.

Bye, Jojo
