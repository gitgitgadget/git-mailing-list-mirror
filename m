From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 07/17] revert: Introduce struct to keep command-line options
Date: Wed, 13 Jul 2011 13:26:04 +0530
Message-ID: <CALkWK0n6gOBC4ET5E+_R9x2_gxqxO1ZUP9wwVVcbXvSXgqPQmA@mail.gmail.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-8-git-send-email-artagnon@gmail.com> <20110712180549.GC14120@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 13 09:56:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QguJ4-0007Sf-Ee
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 09:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965029Ab1GMH4Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jul 2011 03:56:25 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47318 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964961Ab1GMH4Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2011 03:56:25 -0400
Received: by wwe5 with SMTP id 5so5713048wwe.1
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 00:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ElFI+uT3YQk1VgmLIqQ37Ikl8k0spJ2BnMurQCn+cyo=;
        b=MO0ZxJDoknAMEvV459swXt7aMNtFCFMBNOvrMDRC27FnMdkPmJ1x43h9LkGzlyHmTz
         At/eUo16/HaiHpc4KI726IxBUlrPQceLgxy1hY0+ufk6hIWtyijL68pv9TN4QPSuI5uF
         u0Tj6ndklB/jI1q+9rYPBDcFJUc05G1v+de/4=
Received: by 10.216.187.65 with SMTP id x43mr692511wem.62.1310543784107; Wed,
 13 Jul 2011 00:56:24 -0700 (PDT)
Received: by 10.216.175.198 with HTTP; Wed, 13 Jul 2011 00:56:04 -0700 (PDT)
In-Reply-To: <20110712180549.GC14120@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177010>

Hi,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> The variable "me" is left as a file-scope static variable because it
>> is not an independent option. =C2=A0"me" is simply a string that nee=
ds to
>> be inferred from the "action" option, and is kept global to save eac=
h
>> function the trouble of determining it independently.
>
> Why not do something like this[1]?
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/176647/foc=
us=3D176730

=46ixed and rebased all.  Thanks.

revert: Introduce struct to keep command-line options

The current code uses a set of file-scope static variables to tell the
cherry-pick/ revert machinery how to replay the changes, and
initializes them by parsing the command-line arguments.  In later
steps in this series, we would like to introduce an API function that
calls into this machinery directly and have a way to tell it what to
do.  Hence, introduce a structure to group these variables, so that
the API can take them as a single replay_options parameter.  The only
exception is the variable "me" -- remove it since it not an
independent option, and can be inferred from the action.

Unfortunately, this patch introduces a minor regression.  Parsing
strategy-option violates a C89 rule: Initializers cannot refer to
variables whose address is not known at compile time.  Currently, this
rule is violated by some other parts of Git as well, and it is
possible to get GCC to report these instances using the "-std=3Dc89
-pedantic" option.

-- Ram
