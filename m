From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH updated] git wrapper: DWIM mistyped commands
Date: Sat, 30 Aug 2008 18:44:15 +0200
Message-ID: <81b0412b0808300944p29199600ie95c65404b6cb380@mail.gmail.com>
References: <20080828171533.GA6024@blimp.local>
	 <20080828212722.GF6439@steel.home>
	 <7vsksm1pmd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 18:45:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZTZi-00029c-14
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 18:45:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752792AbYH3QoR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 12:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752604AbYH3QoR
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 12:44:17 -0400
Received: from rv-out-0506.google.com ([209.85.198.225]:37268 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752716AbYH3QoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 12:44:16 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1285752rvb.1
        for <git@vger.kernel.org>; Sat, 30 Aug 2008 09:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ROmG3gZc2jCNiceyJYW6TPe9p/2fUlpddn8km1062lo=;
        b=wbNPywDCvY0EruqSRny+2ys6dpZPriZ+nfYWL9/UvrVfEvtsNHUqm3OVU3KrukolIp
         nUW33B62L47vDeo3Bv7jsE1nkxr/LryB3GNf2f8XUX5RG7Su5fMgo7eNZfkky/AcQ1Yb
         jVEe/l18ZN22FVkoUP2HLTdLFsPEM28BGMUfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=h6mG+nVEKBtfiL5rK7WnAWNXyIB/ADyaRGPEmFs5Mm0gpCXsrZ6rLTvcVkVY8gQRq0
         YRhsWZJI9WhP7sbP/UhU87lCx6eU31wrB0ggIUP1iZAC0fijvcLZ/PbZJjsRpDHahiaE
         S1Zyp07IGrP1JGPhccqSCJNKvoBcQUs0iB7fY=
Received: by 10.114.184.7 with SMTP id h7mr3844796waf.9.1220114655529;
        Sat, 30 Aug 2008 09:44:15 -0700 (PDT)
Received: by 10.114.157.9 with HTTP; Sat, 30 Aug 2008 09:44:15 -0700 (PDT)
In-Reply-To: <7vsksm1pmd.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94386>

2008/8/30 Junio C Hamano <gitster@pobox.com>:
>> +static int levenshtein_compare(const void *p1, const void *p2)
>>  {
>> +     const struct cmdname *const *c1 = p1, *const *c2 = p2;
>> +     const char *s1 = (*c1)->name, *s2 = (*c2)->name;
>> +     int l1 = similarity(s1);
>> +     int l2 = similarity(s2);
>> +     return l1 != l2 ? l1 - l2 : strcmp(s1, s2);
>> +}
>> ...
>> +     levenshtein_cmd = cmd;
>> +     qsort(main_cmds.names, main_cmds.cnt,
>> +           sizeof(*main_cmds.names), levenshtein_compare);
>
> Isn't this awfully inefficient?
>
> You have one mistyped command name to compute distance against, and want
> to sort the available 100+ command names by that distance.  In qsort(),
> levenshtein_compare() will be called O(N log N) times (depending on your
> qsort implementation)?

not only similarity, but strcmp as well.

> I wonder if it makes sense to give an otherwise unused "score" member to

Hmm, it is a _non-existing_ member of cmdname, isn't it?

> the "struct cmdname", compute the distance only once per each command, and
> use that as the sort key (alternatively you can have a separate int[N]
> array to store similarity values for each item in the cmdnames list, only
> used inside this codepath).

I think I'll take the struct cmdname->len over.
