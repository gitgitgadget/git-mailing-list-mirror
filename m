From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [PATCH] format-patch: introduce format.outputDirectory configuration
Date: Fri, 19 Jun 2015 23:19:26 +0600
Message-ID: <CANCZXo5Nyt+JePQP=kvFsjTaV=xKXduoBqAwp5E0CrEf13QK7g@mail.gmail.com>
References: <1434626280-4610-1-git-send-email-kuleshovmail@gmail.com>
	<xmqq616ley7y.fsf@gitster.dls.corp.google.com>
	<20150618195751.GA14550@peff.net>
	<xmqqoakceq8s.fsf@gitster.dls.corp.google.com>
	<xmqqk2v0eq75.fsf@gitster.dls.corp.google.com>
	<20150618201323.GB14550@peff.net>
	<20150618202205.GA16517@peff.net>
	<xmqqd20sd70j.fsf@gitster.dls.corp.google.com>
	<CANCZXo72BscpXKGAtVPt_1QuffcOpTz6nGB+__q0JLisuTaKsQ@mail.gmail.com>
	<xmqq616jbse8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 19:19:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5zwz-0004ow-1x
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 19:19:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755183AbbFSRT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 13:19:28 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:36015 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753819AbbFSRT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 13:19:28 -0400
Received: by lacny3 with SMTP id ny3so78116826lac.3
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 10:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Ij9R+ZjLdNIrZrx262v/CSWIK5EqR875zZzQ5pfmhtM=;
        b=TSeu2y4MGZqZlN/rA1ojmENKKlb2QAf7gJ47fV8WPrKSpFxtLeVzVk51jhoHSJoBL4
         L9r3ezDXZBkoPthmiXys19czHJrL1YCMrOXp+VOZ2Bz5TZHBMjvZGJ5FOEzLc1qMySrv
         EQnlOzgKxKF0CAekvVBkBtnfA099WGfoaUFCVJTQh5kBpF5Y9vACT8EwrJXHIFg55Kkr
         pXz6s5LztPv4+lpgFj9R5uYkE2kMCKKM2YKFscLvX8MHVvZYy1/pJVS+qky0npsp6Ka2
         kOwkgYIkBWstrzoG470tt89X96NeTFnV4MQradPyDbeF68PCF4rv4xa8CHS++TQGGo64
         HL8A==
X-Received: by 10.152.44.193 with SMTP id g1mr18822946lam.15.1434734366642;
 Fri, 19 Jun 2015 10:19:26 -0700 (PDT)
Received: by 10.25.62.150 with HTTP; Fri, 19 Jun 2015 10:19:26 -0700 (PDT)
In-Reply-To: <xmqq616jbse8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272168>

> I thought I made that "if we did not see '-o dir' on the command
> line, initialize output_directory to what we read from the config"
> before we make a call to set_outdir().
>
> What I am missing?
>
> Puzzled...  FWIW, IIRC, the patch you are responding to passed the
> test you added.

Ok, Now we have:

if (!use_stdout)
        output_directory = set_outdir(prefix, output_directory);
else
        setup_pager();

and

if (output_directory) {
    // test that we did not pass use_stdout and mkdir than
}

If we didn't pass --stdout and -o the set_outdir will be called
and there is

static const char *set_outdir(const char *prefix, const char *output_directory)
{
    //printf("is_absoulte_path %d\n", is_absolute_path(output_directory));
    if (output_directory && is_absolute_path(output_directory))
        return output_directory;

    if (!prefix || !*prefix) {
        if (output_directory)
            return output_directory;
        return "./";
    }
....
}

So it returns "./", output_directory will not be null. After this

>> +       if (!output_directory && !use_stdout)
>> +               output_directory = config_output_directory;

clause will not be executed never. Or I've missed something?

Thank you.
