From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 1/3] submodule: implement `list` as a builtin helper
Date: Wed, 02 Sep 2015 00:20:56 -0700
Message-ID: <xmqqk2s9p9rb.fsf@gitster.mtv.corp.google.com>
References: <1441131869-29474-1-git-send-email-sbeller@google.com>
	<1441131869-29474-2-git-send-email-sbeller@google.com>
	<xmqqtwrdrk1k.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: sunshine@sunshineco.com, git@vger.kernel.org, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de, peff@peff.net
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 09:21:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZX2Lz-0003cQ-6o
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 09:21:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbbIBHVB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 03:21:01 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35893 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753AbbIBHVA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 03:21:00 -0400
Received: by pacwi10 with SMTP id wi10so2088593pac.3
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 00:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=K9V/b3wcNWoA/LSAbhNJNzDMlBVTaoGwfeyIwtWxfiM=;
        b=Hzx6wuywDxMffJSAMDxT9UHzaETaQWg5MH4IW+VNcFpBcsrRDepLUlq9AWnNuljTpS
         79Ga+elTdwdLRJjp9lun6YzIg6QwRJ4kEqVaj1WHPQjTLFXmI2irJpPOBzuxOR7kmu7V
         6CJYlXJngdDyQWK4cXHL70FAlvguhrmAb0EXnGjryFjTUfrMDVDefIBRdnmCQbTYBb1a
         apph+zKjHKg2JtI38M12XtxEIdkebpk3jSYjJ3S9cwFPLgSsJDQk+UvMM5EvXPxop+ME
         A03DErT/vhl6aaMmA6gPKb7x2YNG3NzpPrltbRavJK68isEVjsRhAuFP2n1T/aRyu+Nm
         Sqig==
X-Received: by 10.66.144.200 with SMTP id so8mr53124539pab.63.1441178459996;
        Wed, 02 Sep 2015 00:20:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:2414:9e5f:bc96:1638])
        by smtp.gmail.com with ESMTPSA id yu2sm20646834pac.33.2015.09.02.00.20.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 02 Sep 2015 00:20:59 -0700 (PDT)
In-Reply-To: <xmqqtwrdrk1k.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 01 Sep 2015 12:55:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277076>

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>> +static int module_list_compute(int argc, const char **argv,
>> +				const char *prefix,
>> +				struct pathspec *pathspec)
>> +{
>> ...
>> +	for (i = 0; i < active_nr; i++) {
>> +		const struct cache_entry *ce = active_cache[i];
>> +
>> +		if (!match_pathspec(pathspec, ce->name, ce_namelen(ce),
>> +				    max_prefix_len, ps_matched,
>> +				    S_ISGITLINK(ce->ce_mode) | S_ISDIR(ce->ce_mode)))
>> +			continue;

Another minor thing I noticed here is that ce->ce_mode would never
be S_ISDIR().

It is not immediately clear if it is necessary to pass is_dir=true
upon S_ISGITLINK(ce->ce_mode) to match_pathspec(), but I think that
is probably a right thing to do.  The only difference this makes, I
think, is when a pathspec ends with a slash.  E.g. when you have a
submodule at path ce->ce_name == "dir" and the caller says "dir/".
Then DO_MATCH_DIRECTORY logic would say "dir/" does match "dir".

So taken together with the remainder of the loop, perhaps

        for (i = 0; i < active_nr; i++) {
                ce = active_cache[i];

                if (!S_ISGITLINK(ce->ce_mode) ||
                    !match_pathspec(..., is_dir=1))
                        continue;

                ALLOC_GROW(ce_entries, ce_nr + 1, ce_alloc);
                ce_entries[ce_nr++] = ce;
                while (...)
                        skip the entries with the same name;
        }

would be what we want.  Pathspec matching is much more expensive
than ce_mode check, and after passing that check, you know the last
parameter to the match_pathspec() at that point, so the above
structure would also make sense from performance point of view, I
think.  And of course, the structure makes it clear that we only
care about GITLINK entries and nothing else in this loop, so it is
good from readability point of view, too.
