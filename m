From: Lukas Fleischer <lfleischer@lfos.de>
Subject: Re: [PATCH] Allow hideRefs to match refs outside the namespace
Date: Sat, 31 Oct 2015 09:49:17 +0100
Message-ID: <20151031084917.26006.98611@typhoon.lan>
References: <1445846999-8627-1-git-send-email-lfleischer@lfos.de>
 <1446046920-15646-1-git-send-email-lfleischer@lfos.de>
 <xmqq1tcfm09k.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 09:49:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsRr9-0003cT-Lw
	for gcvg-git-2@plane.gmane.org; Sat, 31 Oct 2015 09:49:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752440AbbJaIt0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2015 04:49:26 -0400
Received: from elnino.cryptocrack.de ([46.165.227.75]:44252 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036AbbJaItX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Oct 2015 04:49:23 -0400
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTPSA id 6dd55877;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	Sat, 31 Oct 2015 09:49:18 +0100 (CET)
In-Reply-To: <xmqq1tcfm09k.fsf@gitster.mtv.corp.google.com>
User-Agent: alot/0.3.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280569>

I wrote this email on Thursday but it seems like it did not make it
through the mailing list. Resubmitting...

On Wed, 28 Oct 2015 at 17:21:59, Junio C Hamano wrote:
> Lukas Fleischer <lfleischer@lfos.de> writes:
> 
> > Right now, refs with a path outside the current namespace are replaced
> > by ".have" before passing them to show_ref() which in turn checks
> > whether the ref matches the hideRefs pattern. Move the check before the
> > path substitution in show_ref_cb() such that the hideRefs feature can be
> > used to hide specific refs outside the current namespace.
> >
> > Signed-off-by: Lukas Fleischer <lfleischer@lfos.de>
> > ---
> > The other show_ref() call sites are in show_one_alternate_sha1() and in
> > write_head_info(). The call site in show_one_alternate_sha1() is for
> > alternates and passes ".have". The other one is
> >
> >     show_ref("capabilities^{}", null_sha1);
> >
> > and is not relevant to the hideRefs feature. Note that this kind of
> > breaks backwards compatibility since the "magic" hideRefs patterns
> > ".have" and "capabilities^{}" no longer work, as explained in the
> > discussion.
> 
> If somebody is using namespaces and has "refs/frotz/" in the
> hiderefs configuration, we hide refs/frotz/ no matter which
> namespace is being accessed.  With this change, with the removal the
> check from show_ref(), wouldn't such a repository suddenly see a
> behaviour change?
> [...]

It would indeed. However, we cannot stay 100% backwards compatible when
adding support for matching refs outside the current namespace without
introducing new syntax. For example, if Git namespaces are in use (i.e.
GIT_NAMESPACE is set), "refs/namespaces/foo/refs/bar" in hideRefs would
not have hidden refs/namespaces/foo/refs/bar before the change but it
does afterwards. You might argue that nobody would have added
"refs/namespaces/foo/refs/bar" to hideRefs in the first place but
namespaces can be nested and it might be that the user meant to hide
refs/namespaces/bar/refs/namespaces/foo/refs/bar instead. Yes, those are
weird corner cases. But then again, I think that using hideRefs with
namespaces already is a corner case as well. I also think that using the
same syntax to match both original and stripped refs is bad design. It
makes things complicated and the resulting feature doesn't have the full
expressive power of the simpler version only matching original refs.

So, we can either intentionally break backwards compatibility for some
rare corner cases, or keep the current behavior and introduce some new
syntax for matching the original (unstripped) refs. For the latter, we
could either introduce a new option ("hideUnstrippedRefs"?) or special
syntax inside hideRefs ("/refs/foo" instead of "refs/foo" for matching
the unstripped version only?) What do you think?
