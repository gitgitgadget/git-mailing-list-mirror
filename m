From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v4 02/15] mingw: implement syslog
Date: Wed, 13 Oct 2010 14:36:27 +0200
Message-ID: <AANLkTinBvZ_L-fq1u4tPX6rNW6X3jeoOO23-yLpdxSu0@mail.gmail.com>
References: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
 <1286833829-5116-3-git-send-email-kusmabite@gmail.com> <20101011221146.GB6277@burratino>
 <AANLkTinkpTavtw3Rmubfht56tzGnHckHXRc0L-C83daE@mail.gmail.com> <20101011223746.GA6637@burratino>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	avarab@gmail.com, sunshine@sunshineco.com,
	Mike Pape <dotzenlabs@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 14:36:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P60Zj-0004IE-4t
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 14:36:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754140Ab0JMMgt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Oct 2010 08:36:49 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41434 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754072Ab0JMMgt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Oct 2010 08:36:49 -0400
Received: by ywi6 with SMTP id 6so1470686ywi.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 05:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=fgcqoSYNEyCn3ngzGXJ1pDpnlisFiQhkf1Sc32xPIK4=;
        b=FnwQACdtrnQUxXqxWj7q0JS6om1j2ykZAvwSkDlGOk5JALUw+4tTcivdefODZXBuql
         AtgSQ0Vxu5zG73OJ3/RSHXjX2ELRPWjyA74VJm42Fc1RZWEhtN5j9VZV/T/mlj4+rOVk
         rE+mYyvj3l3P4ynAPTfjHrvjkAqQ3b3gLPw/w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=te77tRopJ2jFDl8pvNqf7z1kKno5VoJgu14NRsFtpj8UCm+QD4wJjdQCZtpB9OKnQb
         yEHcdniFtPOeTallUI3sQ6pLwIS05hV7ivfKonph77CKyTYzkDntIEZzgFhoX/M7iAo3
         XjGdWd1y2YnpLtRZnMcVaE6d/Q77jiGjABxQk=
Received: by 10.42.14.138 with SMTP id h10mr3525615ica.491.1286973408239; Wed,
 13 Oct 2010 05:36:48 -0700 (PDT)
Received: by 10.220.45.196 with HTTP; Wed, 13 Oct 2010 05:36:27 -0700 (PDT)
In-Reply-To: <20101011223746.GA6637@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158933>

On Tue, Oct 12, 2010 at 12:37 AM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Erik Faye-Lund wrote:
>
>> The string gets inlined into itself (with a limit of 100 expansions)
>> leading to string like "foo %1 bar" becoming "foo foo foo ... foo %1
>> bar bar bar ... bar". With our expansion, it becomes "foo % 1 bar"
>> instead.
>
> Ah, ok. =A0Sounds like there is no need to worry about requests for "=
%%1"
> etc. =A0Thanks for explaining.
>

Actually, %%1 is a bit of a tricky one. It seems that %%1 is used to
escape %1 on Windows 7, but not on earlier Windows version. I did test
this on Vista an XP earlier, but I'll re-test again later and report
back, in case my earlier tests were flawed.

Can %%1 occur in an IPv6 address at all? If not, I'm tempted to not
handle it (unless it turns out I was wrong about %%1-escaping on Vista
and XP).

> Maybe the symptoms and cases not covered (%2, %%1) would be worth
> mentioning in the log message?
>

Sorry for the late reply.

I'm sure it could be added, I'm just a bit worried about making the
whole commit message too intimidating.

Something like this, perhaps?

---8<---
Strings containing "%1" gets expanded into themselves by ReportEvent,
so let's expand "%1" to "% 1" before reporting, because such string
can occur in IPv6-addresses. "%2" and above does not appear to be a
problem, probably because ReportEvent checks the number against the
wNumStrings parameter first. "%%1" is still a problem, but we don't
have a code-path producing such strings.
---8<---

This is (of course), assuming my current findings are correct.

The lack of documentation on the subject is really annoying.
