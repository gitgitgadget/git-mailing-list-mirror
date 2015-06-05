From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Pack files, standards compliance, and efficiency
Date: Fri, 05 Jun 2015 09:43:15 -0700
Message-ID: <xmqqy4jyrtr0.fsf@gitster.dls.corp.google.com>
References: <20150605014120.GE305479@vauxhall.crustytoothpaste.net>
	<20150605094545.GB11855@peff.net>
	<CACsJy8CnWo=s1onqY33K+DwFmB1baQ-uwu9Fbwm+UB30kDTwQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 18:47:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0uiM-0008Bx-Oj
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 18:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423047AbbFEQnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 12:43:19 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:36475 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422982AbbFEQnR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 12:43:17 -0400
Received: by ieclw1 with SMTP id lw1so61847255iec.3
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 09:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=YpzG8mikUTrFdsvfIkAH11gCF//3YrKsX3IsQtv8YJI=;
        b=vJygdQIbEeOXf8H5IeX9Og/QZ1mUoakJpxdLXRDuhS9EMCbMJOiWychtlahNnF/Lp3
         kp3DseRikEQGZu8Kh5lE1pUuC4CeSPbKIupbrErOMqX2BBUN7Y1R2oz857K8Y710dPI7
         QeXLZPcS8oJUN7Ph5cpUdYZAitMn/nxnCAQ76+vjq382p2RtdboWPsvVa26cMoxc8hSt
         zBYEUY3q3nuiBCioKOFIHm1/jOiRbV5MS85YiR+N8v18CfJNtNb5XFXIU0Qd1qm4QyxP
         OgTZOL2AM/rac3obIiMzUQpNurTw3uZtH0ilHE3nCCFZZ0Hv/bucojKmtgf9PLVHcEcr
         ODYg==
X-Received: by 10.107.166.203 with SMTP id p194mr5679671ioe.30.1433522596868;
        Fri, 05 Jun 2015 09:43:16 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:8c50:e66f:fc40:1825])
        by mx.google.com with ESMTPSA id e10sm1634959igy.11.2015.06.05.09.43.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Jun 2015 09:43:16 -0700 (PDT)
In-Reply-To: <CACsJy8CnWo=s1onqY33K+DwFmB1baQ-uwu9Fbwm+UB30kDTwQw@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 5 Jun 2015 17:14:25 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270855>

Duy Nguyen <pclouds@gmail.com> writes:

> I'm more concerned about breaking object_id abstraction than C
> standard. Let's think a bit about future. I suppose we need to support
> both sha-1 and sha-512, at least at the source code level. That might
> make casting tricky.

If we support both, the code that writes today's objects should be
aware that they are writing today's uchar[20] (or char[40]) object
names, no?  I do not view crusty's series as a step to change the
hash, but more about identifying the arrays used as object names and
differentiating from other char and uchar arrays, so that it will
help us to identify the codepaths that needs to be updated when we
change the hash function.  Ideally, the result of applying his
series should produce the binaries identical to today's code that
uses uchar[20] as object names.

I do not see any "breaking object-id abstraction" involved when
isolated low-level code that writes things to and reads things from
the disk or core knew that the hash we happen to use is uchar[20],
and it is perfectly fine if casting lets us safely take advantage of
that knowledge.  It becomes a problem when we peek into the struct
object_id to find address of sha1[20] and then start passing that
low level address around widely, but I do not think this thread of
discussion has risks to go into that direction.
