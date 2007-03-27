From: Xavier Maillard <zedek@gnu.org>
Subject: Re: [PATCH 2/2] git-blame.el: pick a set of random colors when blaming
Date: Tue, 27 Mar 2007 17:31:58 +0200
Organization: GNU's Not UNIX!
Message-ID: <200703271531.l2RFVwOM008315@localhost.localdomain>
References: <200703262101.l2QL1sGL012549@localhost.localdomain> <87bqifrs7r.fsf@morpheus.local>
Reply-To: Xavier Maillard <zedek@gnu.org>
Cc: git@vger.kernel.org
To: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Tue Mar 27 18:36:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWEeT-0001fk-C0
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 18:36:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933092AbXC0Qfm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 12:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933127AbXC0Qfm
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 12:35:42 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:40794 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933092AbXC0Qfk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 12:35:40 -0400
Received: from localhost.localdomain (chn51-3-88-163-173-156.fbx.proxad.net [88.163.173.156])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 1B93E3609E;
	Tue, 27 Mar 2007 18:35:39 +0200 (CEST)
Received: from localhost.localdomain (IDENT:25@localhost [127.0.0.1])
	by localhost.localdomain (8.13.8/8.13.8) with ESMTP id l2RFWf5j008377;
	Tue, 27 Mar 2007 17:32:41 +0200
Received: (from zedek@localhost)
	by localhost.localdomain (8.13.8/8.13.8/Submit) id l2RFVwOM008315;
	Tue, 27 Mar 2007 17:31:58 +0200
X-Authentication-Warning: localhost.localdomain: zedek set sender to zedek@gnu.org using -f
In-reply-to: <87bqifrs7r.fsf@morpheus.local> (davidk@lysator.liu.se)
User-Agent: Rmail in GNU Emacs 23.0.51.1 on GNU/Linux
Jabber-ID: zedek@im.lolica.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43280>

Hi,

   > I thought it would be cooler to have different set of colors each time
   > I blame.

   But the code for it looks weird:

Why ? It looks good to me except the "small" quircks :)

   > @@ -302,9 +320,8 @@ See also function `git-blame-mode'."
   >            (inhibit-point-motion-hooks t)
   >            (inhibit-modification-hooks t))
   >        (when (not info)
   > -        (let ((color (pop git-blame-colors)))
   > -          (unless color
   > -            (setq color git-blame-ancient-color))
   > +        (let ((color (or (elt git-blame-colors (random (length git-blame-colors)))
   > +			 git-blame-ancient-color)))
   >            (setq info (list hash src-line res-line num-lines
   >                             (git-describe-commit hash)
   >                             (cons 'color color))))

   Instead of using the colors one at a time, you randomly select one of
   them. This means that you might select the same color twice or more,
   and even twice in a row.  And you will never run out of colors, so
   git-blame-ancient-color will never be used.

I partly agree with you.

Random is not enough and we need to delete the color we just
set. This is what I am currently doing in the next patch. There
is still an interrogation: what is the problem if we never fail
and thus, never use git-blame-ancient-color ?

   > * Prevent (future possible) namespace clash by renaming `color-scale'
   > into `git-blame-color-scale'. Definition has been changed to be more
   > in the "lisp" way (thanks for help goes to #emacs). Also added a small
   > description of what it does.

   Ok, but the heavier cl dependency is noted below.

I kept cl but I surrounded it into an eval-when-compile form as
requested by elisp standards.

   > * Do not require 'cl at startup.

   You removed the pop calls, but added a couple of dolist calls.  So you
   still need to require cl.

Yep. See below.

Thank you for your review !

Xavier
