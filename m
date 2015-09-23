From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 06/14] run-command: add an asynchronous parallel child processor
Date: Wed, 23 Sep 2015 07:59:36 -0700
Message-ID: <xmqq6131yyef.fsf@gitster.mtv.corp.google.com>
References: <1442972732-12118-1-git-send-email-sbeller@google.com>
	<1442972732-12118-7-git-send-email-sbeller@google.com>
	<xmqqa8sdzl6a.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, ramsay@ramsayjones.plus.com,
	jacob.keller@gmail.com, peff@peff.net, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	vlovich@gmail.com, sunshine@sunshineco.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 16:59:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZelWK-00007A-8T
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 16:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755006AbbIWO7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2015 10:59:39 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35157 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754733AbbIWO7i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2015 10:59:38 -0400
Received: by pacfv12 with SMTP id fv12so43390375pac.2
        for <git@vger.kernel.org>; Wed, 23 Sep 2015 07:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=tAQHnQjYdtZzGp9DEWcf5xNJHfDKHXA7DrZEJSaEdFk=;
        b=JrCE7gKSn4vOddbFbY9y0A2123SWglok6KaAGkspM6HhkCs3rHdn7bk08S6FuNgdvH
         Xz1df9Cug6YtxSqYZqenN6oAhCQfv/ujyROPcg1sK2CQX84S/fjt8692mszcw18SCIgW
         rH25dqovwWOy/IuuSv0b9OidqqlxbIoPK6wtK2ZCyl8yq9rDvh0XWBst8x50jRspEf7T
         29xHCMkDtvcFuJi+2wYY42V1WTG2HNoWkrtPHQG8jCJ/qHGStXjg1VveS1rzKIOZ67Fq
         udxnaoIJDXBVy+Emi83wnESxCRVF7goJudaMf8hIrpemQ456iDSNs0jzH3BKnXYJdoPn
         FV9Q==
X-Received: by 10.66.219.102 with SMTP id pn6mr37867672pac.80.1443020378344;
        Wed, 23 Sep 2015 07:59:38 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:fd7e:7071:2eda:9c63])
        by smtp.gmail.com with ESMTPSA id eu2sm8490570pbc.48.2015.09.23.07.59.37
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Wed, 23 Sep 2015 07:59:37 -0700 (PDT)
In-Reply-To: <xmqqa8sdzl6a.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 22 Sep 2015 23:47:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278486>

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>> +static void pp_buffer_stderr(struct parallel_processes *pp)
>> +{
>> +	int i;
>> +
>> +	while ((i = poll(pp->pfd, pp->max_processes, 100)) < 0) {
>> +		if (errno == EINTR)
>> +			continue;
>> +		pp_cleanup(pp);
>> +		die_errno("poll");
>> +	}
>> +
>> +	/* Buffer output from all pipes. */
>> +	for (i = 0; i < pp->max_processes; i++) {
>> +		if (pp->children[i].in_use &&
>> +		    pp->pfd[i].revents & POLLIN)
>> +			if (strbuf_read_once(&pp->children[i].err,
>> +					     pp->children[i].process.err, 0) < 0)
>> +				if (errno != EAGAIN)
>> +					die_errno("read");
>> +	}
>> +}
>
> I think it is a good thing that the caller is passing the whole pp
> to this function.  One thing you may want to consider is to adjust
> the poll(2) timeout longer when the process slots are full.
> ...
> But that falls into performance tuning that
> can and should be left to a later follow-up patch after we get the
> basic machinery right.

Just to make sure there is no misunderstanding, just like I prefer
"start one" over "start as many as possible" in order to give
scheduling decision to the calling loop, I would expect that such a
follow-up performance tuning would be done by adding another field
to pp tht lets the caller of this function, the overall scheduling
loop, to tweak the timeout used, without this function making the
decision locallly.

Thanks.
