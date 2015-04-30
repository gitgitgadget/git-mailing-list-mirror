From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v9 1/5] sha1_file: support reading from a loose object
 of unknown type
Date: Thu, 30 Apr 2015 10:10:11 +0530
Message-ID: <5541B22B.6040403@gmail.com>
References: <5540D397.8020104@gmail.com> <1430311933-23180-1-git-send-email-karthik.188@gmail.com> <xmqqtwvzt2fv.fsf@gitster.dls.corp.google.com> <554119F6.5010900@gmail.com> <xmqq383i6849.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 06:40:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YngGr-0004X1-Ol
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 06:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbbD3EkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2015 00:40:17 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:35257 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967AbbD3EkP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2015 00:40:15 -0400
Received: by pdbqd1 with SMTP id qd1so48721400pdb.2
        for <git@vger.kernel.org>; Wed, 29 Apr 2015 21:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=6hoyS+++LzL6OYXHNnHm8GUX5z1Sb0VSbf9Vv0uGlqg=;
        b=kORF1qYd/I0PUZPRT8+ytWyFbUxpapB+OXjzIxAfbxAvwK1HnwIZ2htGuFyDD/HCO5
         NDMjE3r1ihQcNwBPHxXCg3zselfqtuo62bx4Z5E86TzyV18WLIVXD63qpTDcm4obi34a
         jOXK5zsKqOELdSSJmoXlHEgIwyNN7iwwiMv4pWnCRHJ1CskrXQN/CjjlJLXNxH/uKmFC
         1dyQUtb+7YlMZwKegsxMZckrwEMehSP9ujse8C3LTMxg/327phiqPQ2A46PMdQ4zW1sd
         xdatvoIs3XumVSr3YS8athX/tN2CBRSECD9Zy3NtEXiEWRhh0sPeNkPqmTF419kZrNxe
         60AA==
X-Received: by 10.67.8.71 with SMTP id di7mr4694651pad.46.1430368814901;
        Wed, 29 Apr 2015 21:40:14 -0700 (PDT)
Received: from [192.168.0.104] ([103.227.98.178])
        by mx.google.com with ESMTPSA id bz11sm743712pdb.34.2015.04.29.21.40.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Apr 2015 21:40:14 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <xmqq383i6849.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268055>


On 04/30/2015 01:05 AM, Junio C Hamano wrote:
> karthik nayak <karthik.188@gmail.com> writes:
>
> > On 04/29/2015 08:19 PM, Junio C Hamano wrote:
> >> Karthik Nayak <karthik.188@gmail.com> writes:
> >>
> >>> Update sha1_loose_object_info() to optionally allow it to read
> >>> from a loose object file of unknown/bogus type; as the function
> >>> usually returns the type of the object it read in the form of enum
> >>> for known types, add an optional "typename" field to receive the
> >>> name of the type in textual form and a flag to indicate the reading
> >>> of a loose object file of unknown/bogus type.
> >>>
> >>> Add parse_sha1_header_extended() which acts as a wrapper around
> >>> parse_sha1_header() allowing more information to be obtained.
> >>
> >> Thanks.  This mostly looks good modulo a nit.
> >
> > Sorry didn't get what you meant by "modulo a nit.".
>
> "nit" as in "Nit-pick"; a small imperfection that may need to be
> corrected (such as the "what if we saw failure earlier and 'status'
> already had a value?" issue).
Thanks for clearing that out.
>
> >> It is a good trade-off between complexity and efficiency.  The
> >> complexity is isolated as the function is file-scope-static and it
> >> is perfectly fine to force the callers to be extra careful.
> >>
> >> But this suggests that the patch to add tests should try at least
> >> two, preferably three, kinds of test input.  A bogus type that needs
> >> a header longer than the caller's fixed buffer, a bogus type whose
> >> header would fit within the fixed buffer, and optionally a correct
> >> type whose header should always fit within the fixed buffer.
> >
> > Yes it is a tradeoff, and it is complex as in the user has to check
> > the strbuf provided to see if its been used. But this like you said I
> > guess its a good tradeoff.
> > About the three tests, My patch checks "a bogus type whose header
> > would fit within the fixed buffer" and "correct type whose header
> > should always fit within the fixed buffer" but will write a test to
> > check "A bogus type that needs a header longer than the caller's fixed
> > buffer"
>
> Yup. Please do so; that would make the test coverage more complete.
>
Yup will do :)
