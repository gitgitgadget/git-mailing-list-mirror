From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 05/22] read-cache: add index reading api
Date: Tue, 09 Jul 2013 22:13:39 +0200
Message-ID: <87txk3pk3w.fsf@gmail.com>
References: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com> <1373184720-29767-6-git-send-email-t.gummerer@gmail.com> <7va9lx100l.fsf@alter.siamese.dyndns.org> <874nc4rewd.fsf@gmail.com> <7vk3l0y7hk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, trast@inf.ethz.ch, mhagger@alum.mit.edu,
	pclouds@gmail.com, robin.rosenberg@dewire.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 22:13:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UweIN-0007yA-MX
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 22:13:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752945Ab3GIUNw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 16:13:52 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:45832 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843Ab3GIUNv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 16:13:51 -0400
Received: by mail-pa0-f48.google.com with SMTP id kp12so5899041pab.35
        for <git@vger.kernel.org>; Tue, 09 Jul 2013 13:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=nDdJyGZtugcr2MIE/K1MbcGL6P2qbeaWFhT3Gbg5ujU=;
        b=dV17G9lc+HWEA2+asuj3JOxbMFaLEcrLPltfsJEWbMoP56/hLFAsy8c0euVkwq/7Xf
         yne/2DJXQbpjG9dVfA88s/lKZ+Lt93BMKuEPeNfL7/klT6k45K9IXKM1Ymo+Zde056rA
         MpfPUQIPAI90bbk9Hw7fBJuo7g4QcnyTgJ8PZTVxwSQIwmfoAZF/WBSfxB4P0bCw1hK+
         Inr8gziNVup5sfmyU8epiHGOVkFvaQ4HrHlZ0zVo16fKhRiC1voxWn9xi6/SR2MwKsgI
         tv8rvuNGOBMnPq5/rZi4DinH7cRu+NjHsIrAXimPqUsVXrPLGgUo77aPjR7w1DXv8hcu
         dNhw==
X-Received: by 10.68.35.131 with SMTP id h3mr4256407pbj.140.1373400830500;
        Tue, 09 Jul 2013 13:13:50 -0700 (PDT)
Received: from localhost ([2001:470:6d:596:9227:e4ff:feea:9196])
        by mx.google.com with ESMTPSA id vi8sm21271801pbc.31.2013.07.09.13.13.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Jul 2013 13:13:50 -0700 (PDT)
In-Reply-To: <7vk3l0y7hk.fsf@alter.siamese.dyndns.org>
User-Agent: Notmuch/0.15.2+119~gf0dfda5 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229998>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Gummerer <t.gummerer@gmail.com> writes:
>
>>> The reader often needs to rewind the read-pointer partially while
>>> walking the index (e.g. next_cache_entry() in unpack-trees.c and how
>>> the o->cache_bottom position is used throughout the subsystem).  I
>>> am not sure if this singly-linked list is a good way to go.
>>
>> I'm not very familiar with the unpack-trees code, but from a quick look
>> the pointer (or position in the cache) is always only moved forward.
>
> I am more worried about o->cache_bottom processing, where it
> currently is an index into an array.
>
> With your ce->next_in_list_of_read_entries change, a natural rewrite
> would be to point at the ce with o->cache_bottom, but then that
> would mean you cannot in-place replace the entries like we used to
> be able to in an array based implementation.
>
> But your series does not seem to touch unpack-trees yet, so I may be
> worried too much before it becomes necessary.

Yes, you're right, as Duy mentioned in the other email I just responded
to it makes sense to keep the index around for now.

I looked at the unpack-trees code a bit, and adding a new api and hiding
index_state->cache[] will probably be a bit harder to do than I
originally thought, so it's best to keep that around for now, as we're
still able to get the benefits from partial loading even if it's not
hidden.
