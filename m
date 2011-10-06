From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [RFC/PATCH] Add multiple workdir support to branch/checkout
Date: Wed, 5 Oct 2011 20:33:35 -0400
Message-ID: <CAG+J_DzZrFx2v09zNxKm2xyA82MyKRTq3AEus3QthtpZYhQn0A@mail.gmail.com>
References: <1317786204-57335-1-git-send-email-jaysoffian@gmail.com>
	<CACsJy8AqYq+YF+rvUp=BBeFUAtUz783iF2jbUp3fO58yLp9ptQ@mail.gmail.com>
	<CAG+J_DygQTD5ibco=-NOiKg0BLgBGFJnvV8zPyhngC2iZv_H8g@mail.gmail.com>
	<7vpqib8jzk.fsf@alter.siamese.dyndns.org>
	<CAG+J_Dz-GXvRbYUXSoyfyHfOO-_BszcOza9x=ysHhmL5YBW-Jw@mail.gmail.com>
	<7vzkhf713u.fsf@alter.siamese.dyndns.org>
	<CACsJy8BHeZZqsOP_+OSPfrPdkYgKQe3LgaGfo3bERD+hWT7U0g@mail.gmail.com>
	<7vaa9f59p5.fsf@alter.siamese.dyndns.org>
	<CACsJy8D5FGr3R0tLYOND0kKNct4e_KgYfLUK8xL2Q4uNzWczgQ@mail.gmail.com>
	<7vwrcj3sow.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 02:33:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBbu9-0002xb-Tm
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 02:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935493Ab1JFAdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 20:33:37 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43038 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935355Ab1JFAdg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 20:33:36 -0400
Received: by gyg10 with SMTP id 10so2111847gyg.19
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 17:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=aC60BbWLavvHTdsMm//qUM3hH31O8pMZy4+7LKmmkBo=;
        b=BjBA94tjwwiOA3cKaC992w79njxCZq4n7vJ7mbLpsj2g0GqhpV9VsWWo1sbO2dqk82
         bfrOJmulxzCCvffjv1g33woqgnZFzA2ylhUS/0KDNh8AXeivv11CBG+B27I3JmRLgn/q
         4apDaRS8w6TBuodChynFsMtNVuIrFH0nH5YlE=
Received: by 10.147.154.12 with SMTP id g12mr50843yao.36.1317861215901; Wed,
 05 Oct 2011 17:33:35 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Wed, 5 Oct 2011 17:33:35 -0700 (PDT)
In-Reply-To: <7vwrcj3sow.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182907>

On Wed, Oct 5, 2011 at 7:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
> This reminds me of how we ended up handling the "scary warning" around
> detached HEAD. It is not wrong nor even dangerous to detach. It is not
> wrong nor even dangerous to make commits on detached HEAD. It is however
> dangerous to switch away from that state without saving it to a ref, and
> that is where we give warnings.

If you have the same branch in two workdirs, then if you commit to
that branch in one workdir, you have to reset --hard in the other. In
that case, wouldn't it make more sense to just use a detached head in
the second workdir?

  $ git checkout topic
  fatal: branch 'topic' is currently checked out in '...'
  $ git checkout topic^0
  ... topic is updated elsewhere ...
  $ git reset --hard topic

Either way you need to use reset --hard if topic is updated outside of
the current workdir, but at least if git encourages you to detach
first, you don't accidentally undo a commit.

Also, if we wait till commit time to tell the user "sorry, topic's
been updated elsewhere", now the user is in a perilous state. They
have uncommitted work which they clearly want on topic. And they have
to think about what steps are needed to get it there.

So, I really don't think this is quite analogous to detached HEAD, nor
pushing into a repo's checked out branch. In both those cases, at
least the user's work is already committed.

Better to prevent checking out the same branch in multiple workdirs
with an override for users that want risk shooting their foot off.

j.
