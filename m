From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/5] sequencer: factor code out of revert builtin
Date: Tue, 15 Nov 2011 03:47:40 -0600
Message-ID: <20111115094739.GA23139@elie.hsd1.il.comcast.net>
References: <1320510586-3940-1-git-send-email-artagnon@gmail.com>
 <1320510586-3940-2-git-send-email-artagnon@gmail.com>
 <20111106001232.GC27272@elie.hsd1.il.comcast.net>
 <CALkWK0n7v15n_s3CNq1Qu3LHjYkV-ENAkv2b+oB+VBkyV+Sphw@mail.gmail.com>
 <7vvcqnmxeu.fsf@alter.siamese.dyndns.org>
 <CALkWK0mtmRYyFosQNJixhheUmHpRjWc4A5zPQ6AaBfmw4H4eLQ@mail.gmail.com>
 <buo4ny5u4k6.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Tue Nov 15 10:47:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQFcQ-0005ct-Ao
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 10:47:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754638Ab1KOJrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 04:47:49 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:53193 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754599Ab1KOJrs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 04:47:48 -0500
Received: by iage36 with SMTP id e36so8250268iag.19
        for <git@vger.kernel.org>; Tue, 15 Nov 2011 01:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=FYwcxhiVNGvYWgM0aX18JD002VQfFjr0uWSpmsFphCs=;
        b=CGNALp52pIbzX+IJ/3eWnWBEk3jdDkWvgJ6iR94zM3SomuInSAcBr3WlI5tOVAtjL5
         /U9OxZT5NW5WnJfoV8nS8UbpiT6vg76wsK3dfepNFnTzPHE+z72VIVwY9v5F4/BOGvue
         SiQ8SexmwKhnAYCT3woVBTont2zu0GueMxZuU=
Received: by 10.42.161.196 with SMTP id u4mr16393837icx.31.1321350468213;
        Tue, 15 Nov 2011 01:47:48 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id z10sm34197953ibv.9.2011.11.15.01.47.46
        (version=SSLv3 cipher=OTHER);
        Tue, 15 Nov 2011 01:47:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <buo4ny5u4k6.fsf@dhlpc061.dev.necel.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185449>

Miles Bader wrote:

> Does git not use the common practice of self-contained headers?

It usually does, with two exceptions.

Headers do not usually include git-compat-util.h directly, which is a
good thing, since it reminds callers to include git-compat-util.h
before anything else.

Headers might sometimes forget to declare types defined in cache.h,
which would be a mistake.  For example, in branch.h we see:

 int validate_new_branchname(const char *name, struct strbuf *ref, int force, int attr_only);

Which means the following code does not type-check:

 #include "git-compat-util.h"
 #include "branch.h"
 #include "strbuf.h"

 int demo(const char *name, struct strbuf *ref)
 {
	return validate_new_branchname(name, ref, 0, 0);
 }

Reordering the #includes to put strbuf.h before branch.h is a possible
workaround.  Adding the missing forward declaration is better:

diff --git i/branch.h w/branch.h
index 1285158d..d5240a20 100644
--- i/branch.h
+++ w/branch.h
@@ -1,6 +1,9 @@
 #ifndef BRANCH_H
 #define BRANCH_H
 
+struct strbuf;
+enum branch_track;
+
 /* Functions for acting on the information about branches. */
 
 /*
-- 
