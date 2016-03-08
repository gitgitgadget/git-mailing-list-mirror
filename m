From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [BUG?] fetch into shallow sends a large number of objects
Date: Tue, 8 Mar 2016 19:33:43 +0700
Message-ID: <CACsJy8Dk_g1O98UsDaeVS3VXmE2Mn5aR+w1OiFir+QwyJYLVZQ@mail.gmail.com>
References: <20160307221539.GA24034@sigill.intra.peff.net> <xmqqio0xn93q.fsf@gitster.mtv.corp.google.com>
 <20160308121444.GA18535@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 08 13:34:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adGqC-0006Jt-6K
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 13:34:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbcCHMeR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 07:34:17 -0500
Received: from mail-lb0-f170.google.com ([209.85.217.170]:35494 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbcCHMeP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 07:34:15 -0500
Received: by mail-lb0-f170.google.com with SMTP id bc4so16094923lbc.2
        for <git@vger.kernel.org>; Tue, 08 Mar 2016 04:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=e+aEpwxTtaYGMlfKFor5D1hOZLZxUvmAKZieyL8abvE=;
        b=DrMCDY/dbIOics8b6qygDMnck8h2E084aOOgtHIZ7Gt6d7iFLlO5mWzkZGpjxauT37
         MVrjWXbpljfmw1t7SwYmsK4vRTk6imFbGl1UxpE67vzOjEJ2Xxm6xwfLGPTActrd6L9j
         kcUP0jI/o0G6In3AcdCJojH/qRBgat6iBZJ/zHYNj3RE8PEgSt8Wzyea2q232CPCiDF6
         DBt01t4ouiJY69XfXidY1JLUtw5OCWpqxF+W2exgSam5CEdvcdEr6CvfsB68mcMZ6jim
         nOO85jSYDMAUgGxapVK2JViixSBJlHkBOaBIOZO5p5B+xl+I49xzCLnAcCLHvhuWQhAI
         OQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=e+aEpwxTtaYGMlfKFor5D1hOZLZxUvmAKZieyL8abvE=;
        b=CHrxCOEdIUv+XyTf0oo3QyoWaYzsI6OpyN7DKKLwlaP16xfpeyWwynjDYZJbG30M75
         M1/trAzWmlE5zmEH3SxaiNCkMpSF7zg/UJdf2dTrLzOdvzErX/4IJOnOqsc5QJN2DLUC
         E6jgVxrvrPqO7js+Agr5zYOWQ28k6J5Rj/VRBcwF0+Xi68C2gZ/EN1Sw8Cnal3IGKDdg
         wikmCM3/V9aKzu5SNwfHUf+J+oDPZ3ZXxRQWBtu1yaD31oXuJ5JTIyXncBkVIMhCYuEI
         zPL8ntTYtXpBY7COMoksH9ERHDcmwbjyAgetM1Fw8V6fDFJBmq3ELze85wkaoUAiLSKV
         rFeQ==
X-Gm-Message-State: AD7BkJJdxm/aZe3Sx3ZUO7FKS2p2q4mtF4HF6O5NlIlsSECoUCdc7y4wqVy9ZmINmkItbEMvOd9ssuAAh9s6Pg==
X-Received: by 10.25.24.100 with SMTP id o97mr5524644lfi.112.1457440453472;
 Tue, 08 Mar 2016 04:34:13 -0800 (PST)
Received: by 10.112.167.10 with HTTP; Tue, 8 Mar 2016 04:33:43 -0800 (PST)
In-Reply-To: <20160308121444.GA18535@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288431>

On Tue, Mar 8, 2016 at 7:14 PM, Jeff King <peff@peff.net> wrote:
> ...
>
> So I think the solution to both is that we need to do a _separate_
> traversal with all of the positive tips we're going to send, and the
> parents of any shallow commits the client has, to find their fork points
> (i.e., merge bases). And then we add those fork points to the shallow
> list (grafting out their parents), and communicate them to the client to
> add to its shallow setup.

Good news. We have the mechanism in place, I think.
get_shallow_commits_by_rev_list() (from 'pu') will produce the right
shallow points for sending back to the client if you pass "--not
<current shallow points>" to it. It's meant to be used for
--shallow-exclude and --shallow-since, but if neither is given (nor
--depth) I guess we can run it with current shallow points. I wonder
if we can detect some common cases and avoid commit traversing this
way though.
-- 
Duy
