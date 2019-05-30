Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD8411F462
	for <e@80x24.org>; Thu, 30 May 2019 18:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfE3S3e (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 May 2019 14:29:34 -0400
Received: from resqmta-po-01v.sys.comcast.net ([96.114.154.160]:34614 "EHLO
        resqmta-po-01v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726079AbfE3S3d (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 May 2019 14:29:33 -0400
Received: from resomta-po-01v.sys.comcast.net ([96.114.154.225])
        by resqmta-po-01v.sys.comcast.net with ESMTP
        id WNAnh5cQ6HkmzWPnxhA0Fb; Thu, 30 May 2019 18:29:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1559240973;
        bh=+XK5S3iLcelfcn7xRBOJ4tZz02fSHYmplNZGzQ43l8Y=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=b8xeRSDNQSviA/xVUOZhG/jApkgGHVWfOboiyn/sMnFDDpvghAGeOKp5Vc2w3GwTq
         bsm7NAqJLhJK+7ydCmYKIet2xFmjN/+D5olJmcfMHkk27ynO6+yYbGptlNkc675I3v
         ijZOd0i0EtUey9aabkB9kwwQUcbtl+O+/mtDM7zqdRM8QSEkBfznyHoMLOPOhpigwB
         q7iWeCF9lMfk0t+TT2iibGrJYpiqKE0ho02UESKWnpj9j4Pzk5Tt1rB6aLZ4B8wU90
         eI8RVsegTYmkJa5IIa0DbjDpEkwjAUES4CsF00ajfGGElPRacEN23wwbHysntPm06G
         Kmwx5uA8mVLpQ==
Received: from comcast.net ([IPv6:2601:647:4b02:2491:1ed:c9d3:7cb2:4cca])
        by resomta-po-01v.sys.comcast.net with ESMTPSA
        id WPnkhhqn4lRViWPnwhmFnt; Thu, 30 May 2019 18:29:33 +0000
X-Xfinity-VMeta: sc=0;st=legit
Date:   Thu, 30 May 2019 11:29:20 -0700
From:   Matthew DeVore <matvore@comcast.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matthew DeVore <matvore@google.com>, jeffhost@microsoft.com,
        git@vger.kernel.org, emilyshaffer@google.com,
        jonathantanmy@google.com, jrn@google.com, dstolee@microsoft.com,
        jrnieder@gmail.com, pclouds@gmail.com
Subject: Re: [RFC PATCH v2] list-objects-filter: merge filter data structs
Message-ID: <20190530182920.GA4641@comcast.net>
References: <e9147614-80f9-4c18-b431-539e2376295d@jeffhostetler.com>
 <20190530015658.GA4313@comcast.net>
 <xmqqef4fyl9l.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqef4fyl9l.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 30, 2019 at 09:12:06AM -0700, Junio C Hamano wrote:
> > +	union {
> > +		struct {
> 
> Name this, and the ohter two union members, and the union itself as
> one member inside the outer struct; some compilers would be unhappy
> with the GCC extension that allows you to refer to the member in
> this struct as ((struct filter_data *)p)->seen_at_depth, no?
> 

Anonymous unions and structs apparently require C11, which I guess is not
something we want to require.

If I have to name the union and struct, a lot of the conciseness of this
refactor is lost. All accesses of filter data either have to be qualified with
something like filter_data->type_specific.tree.seen_at_depth. If we want to
avoid that messy construct, we are back to assigning an alias pointer of the
correct type as we are doing before this patch anyway.

It's possible there is a clean and concise way to do C-style OO that is better
than what is already here, but this seems to be not worth our time at this
point. For the time being, I'll just change this patch to simplify the API (so
everything is emcompassed in an opaque `struct filter *`) and keep the
implementation more or less as-is.

Thank you for taking a look.
