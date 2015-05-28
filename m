From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] config: add options to list only variable names
Date: Thu, 28 May 2015 12:20:59 -0700
Message-ID: <xmqqbnh4h5k4.fsf@gitster.dls.corp.google.com>
References: <1432757240-4445-1-git-send-email-szeder@ira.uka.de>
	<1432816175-18988-1-git-send-email-szeder@ira.uka.de>
	<1432816175-18988-2-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu May 28 21:21:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy3Ma-0005Zz-9L
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 21:21:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754488AbbE1TVE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 May 2015 15:21:04 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:33027 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753364AbbE1TVC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 15:21:02 -0400
Received: by igbpi8 with SMTP id pi8so793118igb.0
        for <git@vger.kernel.org>; Thu, 28 May 2015 12:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=/aptZUHeSgnG/5kexkno+ZPSACZLXDzSy5nmlGAqWOY=;
        b=v0FUnkHwPTawR2dauVb7172YNBMAtjpV8UXU2haIXkq/tYq154/N8yy7mBednX/+Hn
         1hhMN8Cdf7dMcw+H2WGmPmoWqnhi7f+2wYSt842GF05IgwzxcNOcVVYIU2/P/gpezQ/K
         MNORxKOmdohC7SEPhl0LZQClHNmhx3X7oBtCagiGSHdya0LsYBuwsha0ikwpbcvzTg+S
         Dh4M3hzAmCVr+mEap231vVekGAUp8+FOsczkFZDxSv3OSR2cuRl942X9EHP0ANkQOj0d
         q9ajk1EioWllBnHN1GgBWyq0zlMAYc+ULePFFycFbIkIg2w+ZSHfoTJvGG9z6Xs7QrJ/
         jFgA==
X-Received: by 10.50.110.104 with SMTP id hz8mr13221697igb.38.1432840861414;
        Thu, 28 May 2015 12:21:01 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:89d0:c49e:8012:77d2])
        by mx.google.com with ESMTPSA id k16sm4958390igf.19.2015.05.28.12.21.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 28 May 2015 12:21:00 -0700 (PDT)
In-Reply-To: <1432816175-18988-2-git-send-email-szeder@ira.uka.de> ("SZEDER
	=?utf-8?Q?G=C3=A1bor=22's?= message of "Thu, 28 May 2015 14:29:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270183>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> @@ -16,11 +16,12 @@ SYNOPSIS
>  'git config' [<file-option>] [type] [-z|--null] --get-all name [valu=
e_regex]
>  'git config' [<file-option>] [type] [-z|--null] --get-regexp name_re=
gex [value_regex]
>  'git config' [<file-option>] [type] [-z|--null] --get-urlmatch name =
URL
> +'git config' [<file-option>] [-z|--null] --get-name-regexp name_rege=
x
> ...

At first I wondered why --get-name-regexp is needed, as (purely from
the syntactic level) it appeared at the first glance the existing
'--get-regexp' without 'value_regex' may be sufficient, until I read
this:

> +--get-name-regexp::
> +	Like --get-regexp, but shows only matching variable names, not its
> +	values.

which makes it clear why it is needed.  The distinction is purely
about the output, i.e. the values are omitted.

But then it makes me wonder why --get-name-regexp shouldn't
optionally accept value_regex like --get-regexp does, allowing you
to say "list the variables that match this pattern whose values
match this other pattern".  I know it may be a feature that is
unnecessary for your purpose, but from a cursory look of the patch
text, you do not seem to be doing anything different between
get-regexp and get-name-regexp codepaths other than flipping
omit_values bit on, so it could be that the feature is already
supported but forgot to document it, perhaps?

The 'type' may also be shared between these two options, no?  It
would be logically consistent if you can say

	git config --bool --get-name-regexp '.*' 'no'

to find all configuration variables that are set to 'false' in
different spellings like '0', 'false', 'no', etc.  And I suspect
that the code already supports that.

Tangentially related to the above issue, but

	git config --bool --get-regexp '.*' 'no'

seems to be broken from that point of view.  Instead of ignoring a
non-bool string valued variables, it seems to barf upon seeing the
first such variable.  Interestingly, --get-name-regexp does not
share that breakage ;-)

Which we may want to fix, but not in the scope of this series.

Hint, hint...
