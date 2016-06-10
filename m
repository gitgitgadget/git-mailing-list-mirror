From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 24/26] upload-pack: split check_unreachable() in two, prep
 for get_reachable_list()
Date: Fri, 10 Jun 2016 19:14:18 +0700
Message-ID: <CACsJy8BTWu-meKQcB8Xqa5bniM1z3LNP6eEJe_mmiuPTD5U9_A@mail.gmail.com>
References: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
 <1460552110-5554-25-git-send-email-pclouds@gmail.com> <CAPig+cTyzA1HFt=K14UBPsKhWhHmy0WX8=tru7HQmP3m+GpGgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 14:15:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBLL2-0006Vf-5g
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 14:15:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbcFJMOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 08:14:50 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:34821 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753322AbcFJMOt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 08:14:49 -0400
Received: by mail-io0-f181.google.com with SMTP id o127so17687358iod.2
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 05:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ftnwI2mLr4RHwCDdLjsK7n1DAVffMmlYzSNKAALrfMo=;
        b=l4p+stSmpeR4q63ALlRxLey+wtfHH3j9wyLfVhJ9Edap53k02gvH/9vH0MyyKaR/YU
         mZEUlpBudVw1hfeuI/nTzRQslW/Lyw3fO6D8h3Sc2MzmY2biClXELizYTj9LhR5V/8Hy
         iP71lhjS4NURFRXfZ7AnaZk8V8uGNtzpkBDm1N53ATha86qMcKryalg0/PRENNFkOeHQ
         pDaq/uGhnX4EVZFSu7GcG7lMqxNSJAPnGUhL4es0DVPtBtf6Qp6v3F5+34VO97rJgWEG
         4+Gi73ouKeShWbm2COF3kBV8prf8bS021iQBykJMZEGXhg90oSZI/tVrnZzmmtHky/22
         bHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ftnwI2mLr4RHwCDdLjsK7n1DAVffMmlYzSNKAALrfMo=;
        b=AHuNL7oQU9LMM+5BYM4lkO8UVSF0vHu7Pb12cc2y+xxP1gg81WUKVFXP66LEcihJKZ
         g6fPsgpqWURlIGdC+j6uZpmW3vBRluHhLUN5k8WPmfI87bgvK6/edbkMzXyr/dzJJXgO
         hUucMbcIDwqcBvSYWzHAhjKRrVR2AdKSvfb1U7+h2c+HT0LqlrjpfBAgDqimnIBEn0Y7
         jMz/e3qseORjdc3flXNCrx1lIc9ubOMq5MUGDBSE7++Raw0dcI3OkIk29DuQGrXx1+JN
         4Oh49caVvgBw/5qGnUKriL1OANlaJ+OXu1s+boQGd85xxY+Rw0JETeqwnkr1THr0z5nV
         8U0A==
X-Gm-Message-State: ALyK8tIQWaGzf5wZXO7zZkuywLHTAMHlCSZTwuiPbcnrFSrRfqKZDjdBNuwIaxyF106MnCbAtO2nLNTM6ahXpQ==
X-Received: by 10.107.159.84 with SMTP id i81mr3220591ioe.29.1465560888110;
 Fri, 10 Jun 2016 05:14:48 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Fri, 10 Jun 2016 05:14:18 -0700 (PDT)
In-Reply-To: <CAPig+cTyzA1HFt=K14UBPsKhWhHmy0WX8=tru7HQmP3m+GpGgQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296972>

On Mon, Jun 6, 2016 at 2:43 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>         /*
>>          * The commits out of the rev-list are not ancestors of
>>          * our ref.
>>          */
>> -       i = read_in_full(cmd.out, namebuf, 1);
>> +       i = read_in_full(cmd.out, buf, 1);
>
> s/1/sizeof(buf)/ perhaps or does that make the intent less clear?

Yeah I think so. "1" makes it obvious that we do not care about the
actual content (or at least raise some eyebrows and force the reader
to understand this entire function). sizeof(buf), not so much.
-- 
Duy
