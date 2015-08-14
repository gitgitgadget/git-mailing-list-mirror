From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 4/4] notes: teach git-notes about notes.<ref>.mergestrategy option
Date: Fri, 14 Aug 2015 15:01:53 -0700
Message-ID: <xmqq8u9dh6lq.fsf@gitster.dls.corp.google.com>
References: <1439586835-15712-1-git-send-email-jacob.e.keller@intel.com>
	<1439586835-15712-5-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 00:02:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQN31-00019l-KU
	for gcvg-git-2@plane.gmane.org; Sat, 15 Aug 2015 00:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584AbbHNWBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 18:01:55 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:34245 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163AbbHNWBy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 18:01:54 -0400
Received: by pdbfa8 with SMTP id fa8so35046017pdb.1
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 15:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=cGU2xwflMBMhPm4/br0IQ5Fa7ZF1M/G2N3xDra2/QFE=;
        b=WCpxZuZBJLg/kTMOO65sWA3GdDf1kEDVK2PssQWIz4T5gK42+KkkjiCO49bCTQm7sl
         b6rlyEVPSs2bhmfiZJNfKvyMNmDk3DN2CaxVWeWqumqukjlzp8s68N44jg78oR/3DE/z
         dRuBOyrR2/l64JFt56Ew4JTTZUIuKMqZIQ4FCxo2qkbIvlzB6xW22gzHGdTrVSLTI7Os
         eQ4XirIZ3DMdKoLafOijOixUKWIWkS05l6yxPFbkhZtEwigPGrW1E3JLc6I7s7kAI7Sb
         fUDT/Cj4qdhbr1QEQx4PrcA8vgOgZLUvKPMBw54cr/NQ1V3QZdRVJ/mu+RL/S0DRzL3F
         NOAw==
X-Received: by 10.70.88.37 with SMTP id bd5mr92786209pdb.159.1439589714264;
        Fri, 14 Aug 2015 15:01:54 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a820:aa0d:2b52:954f])
        by smtp.gmail.com with ESMTPSA id m2sm7105611pdr.64.2015.08.14.15.01.53
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 14 Aug 2015 15:01:53 -0700 (PDT)
In-Reply-To: <1439586835-15712-5-git-send-email-jacob.e.keller@intel.com>
	(Jacob Keller's message of "Fri, 14 Aug 2015 14:13:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275964>

Jacob Keller <jacob.e.keller@intel.com> writes:

> diff --git a/builtin/notes.c b/builtin/notes.c
> index 12a42b583f98..bdfd9c7d29b4 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> ...
> @@ -833,7 +833,14 @@ static int merge(int argc, const char **argv, const char *prefix)
>  			usage_with_options(git_notes_merge_usage, options);
>  		}
>  	} else {
> -		git_config_get_notes_strategy("notes.mergestrategy", &o.strategy);
> +		if (!skip_prefix(o.local_ref, "refs/notes/", &short_ref))
> +			die("Refusing to merge notes into %s (outside of refs/notes/)",
> +			    o.local_ref);
> +

Sorry, but I lost track.  

Do I understand correctly the consensus on the previous discussion?
My understanding is:

 (1) We do not currently refuse to merge notes into anywhere outside
     of refs/notes/;

 (2) But that is not a designed behaviour---we simply forgot to
     check it---we should start checking and refusing.

If that is the concensus, having this check somewhere in the merge()
function is indeed necessary, but this looks very out of place.
Think what happens if the user passes "--stratagy manual" from the
command line.  This check is not even performed, is it?

I'd prefer to see:

 * "Let's start making sure that we do not allow touching outside
   refs/notes/" as a separate patch, perhaps as a preparatory step.

 * Have the check apply consistently, regardless of where the
   strategy comes from.

 * That separate patch to add this restriction should test that
   the refusal triggers correctly when it should, and it does not
   trigger when it shouldn't.

> +		strbuf_addf(&merge_key, "notes.%s.mergestrategy", short_ref);
> +
> +		if (git_config_get_notes_strategy(merge_key.buf, &o.strategy))
> +			git_config_get_notes_strategy("notes.mergestrategy", &o.strategy);
>  	}

I think you are leaking merge_key after you are done using it.

It is tempting to suggest writing the above like so:

		git_config_get_notes_strategy(merge_key.buf, &o.strategy)) ||
                git_config_get_notes_strategy("notes.mergestrategy", &o.strategy);

which might make it more obvious what is going on, but I do not care
too deeply about it.  To be honest, I am not sure which one is
easier to read in the longer term myself ;-).

Thanks.
