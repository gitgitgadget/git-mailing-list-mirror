From: Vikrant Varma <vikrant.varma94@gmail.com>
Subject: Re: [PATCH v2 1/2] help: add help_unknown_ref
Date: Fri, 10 May 2013 02:34:22 +0530
Message-ID: <518C0F56.7070600@gmail.com>
References: <1367625860-20746-1-git-send-email-vikrant.varma94@gmail.com> <1367625860-20746-2-git-send-email-vikrant.varma94@gmail.com> <7vzjw5axzk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 09 23:04:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaY0w-00013k-BS
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 23:04:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752813Ab3EIVEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 17:04:30 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:38888 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265Ab3EIVE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 17:04:29 -0400
Received: by mail-pb0-f44.google.com with SMTP id wz17so2271119pbc.17
        for <git@vger.kernel.org>; Thu, 09 May 2013 14:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=X99JPYqhhxAfcviSCORn3iujn6zeZkYOe+xUt+XUVW0=;
        b=nvLzQqiONTJP0kq5RjiQTfmv8rr/3/xQDeOZHCA5wL9LUIZZBaRk3TpMXqRAQYe7rs
         UOXBjKDlRL2+OipQ0qcLIv4o5yip+2DU2sbDRVN/p0zJCyGJHlxZwYohb7pM1nbip2GG
         l7y1cfZkR4+uDcxSX2UsY9+mkdqirZWB3Benzv/iI3ZYQ2VRXpuRxnqK0IAZIkz4ygGU
         fG698p6VBs7KgzgsLWnWtTanXmJB11zLzmSNSqmWDlPPKzsHH6VGiHn/67pTa+XJ6aS6
         XK9em7OenQTiT2CubYcuAiZkBRZzAcsUr9VnQ+wWrTYjQazULV/ZIRFICYlEr9gTQElD
         fdsA==
X-Received: by 10.68.189.67 with SMTP id gg3mr14305174pbc.141.1368133469374;
        Thu, 09 May 2013 14:04:29 -0700 (PDT)
Received: from [192.168.1.4] (triband-mum-59.183.164.63.mtnl.net.in. [59.183.164.63])
        by mx.google.com with ESMTPSA id az5sm4255993pbc.18.2013.05.09.14.04.25
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 09 May 2013 14:04:28 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <7vzjw5axzk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223782>

On Thursday 09 May 2013 04:19 AM, Junio C Hamano wrote:
 > [...] which in turn made me realize that some commands may not even know
 > if the user mistyped a ref.  It is not an objection to this patch
 > per-se, but a useful future enhancement may be to allow the callers
 > call guess_mistyped_ref() directly and let them decide what to do
 > when they suspect the string they did not understand is not a
 > mistyped ref but something else, i.e. not let help_unknown_ref() die
 > unconditionally but allow it to return.  Then the caller can do:
 >
 >          commit = get_commit_from_string(argv[i]);
 >          if (!commit) {
 >              ... I do not understand argv[i], but ...
 >              ... it may be a mistyped ref ...
 >              help_unknown_ref(argv[i], "expected a revision");
 >              ... it is not likely to be a typo ...
 >              ... perhaps it was meant to be a filename? ...
 >              if (file_exists(argv[i])) {
 >                  ... yes! ...
 >                  ... do the "file" thing instead ...
 >              }
 >          }
 >

I'm apprehensive about calling guess_mistyped_ref() (or it's equivalent, 
which happens to be guess_refs()) directly, because it doesn't seem like 
a clean enough separation. When the caller thinks it's got a bad 
refname, it should just hand it over to help_unknown_ref, for further 
processing.

If autocorrect is enabled, it can get back a single corrected refname 
(that is what my next patch will include - is it okay to base it on pu?).

If the need ever did arise to get that kind of information from 
help_unknown_ref, it could always be done using callback data?

	commit = get_commit_from_string(argv[i]);
	if (!commit) {
		... maybe mistyped ref, maybe something else ...
		struct unknown_ref_cb data;
		help_unknown_ref(argv[i], "expected something else",
				 &data);
		if (data.autocorrect)
			commit = get_commit_from_string(
					data.corrected_ref);
		else if (data.is_file)
			... do the file thing instead ...
    	}

I didn't see the need for this right away.

 >> Example:
 >> 	$ git merge foo
 >> 	merge: foo - not something we can merge
 >
 > That leading "merge: " looks somewhat strange, especially when it
 > immediately follows the command line to invoke "merge", making it
 > appear to waste space by stating the obvious.
 >
 > Our messages are generally marked with "error:", "fatal:",
 > "warning:", etc. at the beginning.

I agree, it looks strange. However the alternatives seem to be:

1) hard code 'fatal' into the error message
2) print the corrections before using die()
3) create and store the corrections string beforehand, and then call die()

1 and 3 are not elegant, and 2's output seems harder to read. I haven't 
been able to figure out a way to do this well.
