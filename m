From: Junio C Hamano <gitster@pobox.com>
Subject: Re: suboptimal behavior of fast-import in some cases with "from"
Date: Mon, 06 Jul 2015 15:54:35 -0700
Message-ID: <xmqq4mlgzyl0.fsf@gitster.dls.corp.google.com>
References: <20150706220746.GA29367@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Jul 07 00:54:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCFHe-0004gt-O2
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 00:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756055AbbGFWyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 18:54:38 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:33426 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755209AbbGFWyi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 18:54:38 -0400
Received: by igh16 with SMTP id 16so37879731igh.0
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 15:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=5AmiPEL9RH4x8rQnKQUsWxlj8I4OWK3KgWLTus9ye5s=;
        b=kFT5M/eTnYRL9FlQ2alZU60T/JYLsx52ds3kdXSzZGibW+K/01jCNeCEuwoSrAxgHH
         i4prz3jh+ZQHlP1ZM+n6WGrPIbpPKgNehK+4m7NOhMuTy2MJYHxcbYr0hk6CkuXllX5O
         kkjSoarfyz7rTdywVUQmDLO5cAYXdzrRZU58DoFok5/4ci8lbW7TJGc3VpCrfyL8qX2k
         Bkq8U0KuFSwYMTBGMDkc7NRb2Y5K52G543O9rW6icLcmEvLvYmaBhkGCgQzaBMkNEhmM
         bLZ7Ej+k29et9gU0/Up7SiDi3QpRnqPYsZPNCAHLU0E2a4x2GdP4ws5qPWkX81VpyThE
         6cRA==
X-Received: by 10.107.31.134 with SMTP id f128mr1851704iof.19.1436223277495;
        Mon, 06 Jul 2015 15:54:37 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ad70:2147:d1ba:ffd8])
        by mx.google.com with ESMTPSA id 69sm13386061ioz.10.2015.07.06.15.54.36
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jul 2015 15:54:36 -0700 (PDT)
In-Reply-To: <20150706220746.GA29367@glandium.org> (Mike Hommey's message of
	"Tue, 7 Jul 2015 07:07:46 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273466>

Mike Hommey <mh@glandium.org> writes:

> One of the first things parse_from does is unconditionally throw away
> the tree for the given branch, and then the "from" tree is loaded. So
> when the "from" commit is the current head of the branch, that make
> fast-import do more work than necessary.

If it is very common that the next commit the input stream wants to
create is often on top of the commit that was just created, and if
it is very common that the input stream producer knows what the
commit object name of the commit that was just created, then
optimising for that case does not sound too bad.  It really depends
on two factors:

 - How likely is it that other people make the same mistake?

 - How bad the damage to parse_from() would be if we wanted to
   optimize for this case?
