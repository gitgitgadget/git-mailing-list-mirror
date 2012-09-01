From: Marco Stornelli <marco.stornelli@gmail.com>
Subject: Re: [PATCH v4] Thunderbird: fix appp.sh format problems
Date: Sat, 01 Sep 2012 09:43:16 +0200
Message-ID: <5041BC94.7000304@gmail.com>
References: <5040C59A.6090303@gmail.com> <50412E2D.7070503@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Sep 01 09:50:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7iTl-0001p7-CV
	for gcvg-git-2@plane.gmane.org; Sat, 01 Sep 2012 09:50:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586Ab2IAHt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Sep 2012 03:49:56 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:55651 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350Ab2IAHtz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2012 03:49:55 -0400
Received: by wicr5 with SMTP id r5so2442641wic.1
        for <git@vger.kernel.org>; Sat, 01 Sep 2012 00:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=u6PxPZWigT3dL8AqByYcVZpYOQBR5kAm5eLIyLUOCoE=;
        b=J987kI6WedG3RIqEDF/Vot5WqHhOC+C/OxwdfnaGfV9j+QOoV9uPoi5cOWTuiC7pqU
         v5o7KAKjr06pAzXEWkOD3mjRSZW8z61YbYsfb9HN1ze8ZGqOBXkKy38CvhCslV0p1rRY
         HD0d33u4qivJITIF/+wbD4F55OelS/1kjUvMGGeaBGMUbvBercnKrZDH1bp5YvZCOgGA
         7VjiAnKloddroiXW5g3eKWWifmMJ7H3InBFCX+Jp9ChpySJJTDXybehA5poLFhuuO5oQ
         /G0el1zfa1ZtI8GwUZhth2qPU/IV6a+bxmYzZTpCSvXnxzEp/SmobirBaJc5Lp6eEm84
         7mdg==
Received: by 10.180.8.40 with SMTP id o8mr9788885wia.9.1346485793976;
        Sat, 01 Sep 2012 00:49:53 -0700 (PDT)
Received: from [80.183.108.16] (host16-108-dynamic.183-80-r.retail.telecomitalia.it. [80.183.108.16])
        by mx.google.com with ESMTPS id t8sm5386040wiy.3.2012.09.01.00.49.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 01 Sep 2012 00:49:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:13.0) Gecko/20120601 Thunderbird/13.0
In-Reply-To: <50412E2D.7070503@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204620>

Il 31/08/2012 23:35, Johannes Sixt ha scritto:
> Am 31.08.2012 16:09, schrieb Marco Stornelli:
>> +CCS=`perl -e 'local $/=undef; open FILE, $ENV{'PATCHTMP'}; $text=<FILE>;
>> +close FILE; $addr = $1 if $text =~ /Cc: (.*?(,\n .*?)*)\n/s; $addr =~ s/\n//g;
>> +print $addr;'`
>
> The quoting is broken in this line (sq within sq does not work).

I don't understand what you mean, I'm using this script and it works 
perfectly.

>
> Am I correct that you intend to treat continuation lines with this
> non-trivial perl script? All this processing gets tedious and
> unreadable. Let me suggest this pattern instead:

The perl script is used to have To: and Cc: email addresses in single 
line, without using \n. I tried with sed, but it's a little bit 
difficult (at least for me) because sed usually works on a single line, 
it's tricky with multilines.

>
> # translate to Thunderbird language
> LANG_TO="To:"
> LANG_SUBJ="Subject:"
> LANG_CC="Cc:"
>
> LF=	# terminates the _previous_ line
> while read -r line
> do
> 	case $line in
> 	'To: '*)
> 		printf "${LF}%s" "$LANG_TO ${line#To: }"
> 		;;
> 	'Cc: '*) ...similar...
> 	'Subject: '*) ...similar...
> 	' '*)	# continuation line
> 		printf "%s" "$line"
> 		;;
> 	'')
> 		print "${LF}\n"
> 		cat
> 		;;
> 	esac
> 	LF='\n'
> done <"$PATCH" >"$1"
>
> Instead of printing right away, you can also accumulate the data in
> variables and print them right before the 'cat'. I would do that only if
> a particular order of To:, Cc:, and Subject: is required in the output.
>
> (I don't know how the "do not delete this line" line fits in the
> picture, but I'm sure you can figure it out.)
>
> -- Hannes
>
>
