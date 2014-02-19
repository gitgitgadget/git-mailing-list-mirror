From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git gc --aggressive led to about 40 times slower "git log --raw"
Date: Wed, 19 Feb 2014 17:24:20 +0700
Message-ID: <CACsJy8AQksxT-QROqxCKCjCzfqfz+SNN3=HTCjtRx3G-9GdnKg@mail.gmail.com>
References: <CAEjYwfU==yYtQBDzZzEPdvbqz1N=gZtbMr5ccRaC_U7NfViQLA@mail.gmail.com>
 <87r470ssuc.fsf@fencepost.gnu.org> <CACsJy8D9tws_gu6yWVdz3t+Vfg5-9iorptn4BLnTL3b+YWcHzQ@mail.gmail.com>
 <87ioscsoow.fsf@fencepost.gnu.org> <20140218155842.GA7855@google.com>
 <xmqqzjlocf28.fsf@gitster.dls.corp.google.com> <CACsJy8AEXP45K+r3gGVTWbn4uuPLeHOkf-an20rj77QSfG1-ew@mail.gmail.com>
 <xmqq4n3warni.fsf@gitster.dls.corp.google.com> <CACsJy8C+wGd9WxnsML6-_G_S5GtN2pCPf09kcFtBVu-SDfP8YA@mail.gmail.com>
 <CAGK7Mr4wpwUK6UF6vTmgszX4sajPDvQazY2QagFfH9BEJx_9Ow@mail.gmail.com> <87bny3qxwr.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Philippe Vaucher <philippe.vaucher@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Jaeger <chrjae@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Feb 19 11:24:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WG4Ko-0004F3-JP
	for gcvg-git-2@plane.gmane.org; Wed, 19 Feb 2014 11:24:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753080AbaBSKYx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Feb 2014 05:24:53 -0500
Received: from mail-qg0-f42.google.com ([209.85.192.42]:34749 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbaBSKYv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Feb 2014 05:24:51 -0500
X-Greylist: delayed 41891 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Feb 2014 05:24:51 EST
Received: by mail-qg0-f42.google.com with SMTP id q107so281280qgd.1
        for <git@vger.kernel.org>; Wed, 19 Feb 2014 02:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=UOotVT7lSwE4YQL3zU4cqoy0LOhS0gzyiEdF0R7DHGA=;
        b=dgucpVzpAwuDRaqyYcIWbEq3ms4MNLY2cZ/B7Gu2+htbzM5XSYp/MGfDTQkUNnuMcZ
         w43mV6uA+UQi0psCt5rB5APx7Y14PZUPJ85cXqXwIfHzHoqO9xznRYx8t3cWVllxVqNa
         fB59ZkewsXpITgepMC5pgBMd4JX9MlExya8Icdcc7yNbsd86atP7tLlVN22ZSTWqMU9r
         asQIKwv981zUGg89jAxglZrtJuyUqbxPT/Z3p7Rww5ftp1US2N6mvvMLrpb+yZ+X6uEt
         GQzdGHG5fXP03qoynt9MUav6Gd9+Ysteg8oIg5jNpc/cvXVMf8rhmcnOZBz29BlcETea
         6q1w==
X-Received: by 10.224.167.84 with SMTP id p20mr49756770qay.24.1392805490993;
 Wed, 19 Feb 2014 02:24:50 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Wed, 19 Feb 2014 02:24:20 -0800 (PST)
In-Reply-To: <87bny3qxwr.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242388>

On Wed, Feb 19, 2014 at 4:01 PM, David Kastrup <dak@gnu.org> wrote:
> Calling git blame via C-x v g is a rather important part of the
> workflow, and it's currently intolerable to work with on a number of
> files.
>
> While I'm fixing the basic shortcomings in builtin/blame.c itself, the
> operation "fetch the objects" is necessary for all objects at least
> once.  It's conceivable that some nice caching strategy would help with
> avoiding the repeated traversal of long delta chain tails.  That could
> also help defusing the operation of basic stuff like git-log.

Pack v4 is supposed to tackle this delta chain thing, but its future
is a bit uncertain (you can give a hand btw). If you often do "git
blame", you might consider unpack most accessed objects (make it part
of "blame" process), which would function exactly like a cache with no
extra code. The downside is git-gc --auto is more likely to kick in
because of too many loose objects and pack everything up again.
-- 
Duy
