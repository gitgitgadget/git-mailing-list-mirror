From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v7 0/1] refs.c: SSE4.2 optimizations for
 check_refname_component
Date: Mon, 09 Jun 2014 18:39:03 -0400
Organization: Twitter
Message-ID: <1402353543.18134.203.camel@stross>
References: <1402012575-16546-1-git-send-email-dturner@twitter.com>
	 <xmqqfvjdenk5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 00:39:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu8Dm-0004wR-UI
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 00:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbaFIWjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 18:39:11 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:39936 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932919AbaFIWjH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 18:39:07 -0400
Received: by mail-qg0-f44.google.com with SMTP id i50so9627819qgf.3
        for <git@vger.kernel.org>; Mon, 09 Jun 2014 15:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=vN8TOAuDcHHnzSYl4axYsCZFCd3vmNFZJni9k83aya4=;
        b=TLovo+I2W7nkkuvL4R1cwZaSFNttepYQAQtMXRv6y3CYibfCZIBHdUylSqwTcpzbp/
         W7taq4LJYAqBtCdXxl5m83l9kOfgWNxCXQ+w11aio26rtS+Mj2iM1+YwWR91qYLnsLc6
         T4cAO+msxlTubBIjrgY2WCthOU5Ppe0wH4f9OnoQU7+4Or1pdYGVDP/EIU1CsmCSSUFk
         ZsNz/cmrXZhAHBkRcuBVBMjgvw1mcfvb1hUK1MgQfV6KR68A1l1V7/02iuxxaJjhRI7Y
         AjcrJun0VYzXCnDv/J5gNG4pwqp5QF2EouWbeFj1+6Jg+t0MdQEMPgpuU9qnDc9zVsnA
         RRBA==
X-Gm-Message-State: ALoCoQljJ5oFr4OtuvZSxLNXNxxvzHqgubdfR17OPMNNC4Mcg6bZiMygz2LFysMcxI94kjQaiH99
X-Received: by 10.224.162.212 with SMTP id w20mr7820191qax.50.1402353546366;
        Mon, 09 Jun 2014 15:39:06 -0700 (PDT)
Received: from [172.17.3.188] ([38.104.173.198])
        by mx.google.com with ESMTPSA id s2sm32590580qaj.36.2014.06.09.15.39.05
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Mon, 09 Jun 2014 15:39:05 -0700 (PDT)
In-Reply-To: <xmqqfvjdenk5.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251128>

On Mon, 2014-06-09 at 15:16 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > Since Junio has picked up the first patch from previous versions of
> > this series, I'm just going to send the second (SSE) one.  I decided
> > not to s/NO_SSE42/!HAVE_SSE42/ because it looks like git mostly uses
> > the former convention (for instance, that's what GIT_PARSE_WITH
> > generates).
> 
> Yeah but NO_FROTZ is used only when FROTZ is something everybody is
> expected to have (e.g. it's in posix, people ought to have it, but
> we do support those who don't), isn't it?  For a very arch specific
> stuff like sse42, I'd feel better to make it purely opt-in by
> forcing people to explicitly say HAVE_SSE42 to enable it.

The patch now has two kinds of autodetection:

1. At build-time, we check for the compiler supporting -msse4.2.  If it
does, and if the user has not explicitly done --without-sse, then we
build with SSE support.  This does not mean that the SSE code will
necessarily be used because:
2. At run-time, if we have built with SSE support, we check cpuid to
choose a version of the function that will run on the current CPU.

So I think we never hit a case where we try to use SSE and fail, which
is the major reason I see to make it non-default.

To me, this means that we should not require people to explicitly
request SSE, because we generally want to try to provide the
most-efficient version of git that will work everywhere.  In fact, I am
not sure we need a --without-sse option at all, since all it saves is a
cpuid instruction.  But I don't need to remove the option, in case
there's a use for it I'm not thinking of.
