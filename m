From: Nazri Ramliy <ayiehere@gmail.com>
Subject: Re: [PATCH v3] Teach git to change to a given directory using -C option
Date: Wed, 4 Sep 2013 14:36:47 +0800
Message-ID: <CAEY4ZpN4xgt+gJSVeTfDNC--xt3N+M7vVLFBC7FTWBQtjvN8tw@mail.gmail.com>
References: <20130903115944.GA29542@gmail.com>
	<xmqq8uzdplqv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 04 08:36:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VH6hy-0000fO-3j
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 08:36:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762005Ab3IDGgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 02:36:50 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:43290 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761987Ab3IDGgt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 02:36:49 -0400
Received: by mail-la0-f42.google.com with SMTP id ep20so5499891lab.15
        for <git@vger.kernel.org>; Tue, 03 Sep 2013 23:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NJwlLZ7e+j/EvFz2Lm/tWKKoL0Gco9G4xlnu4ofT1cI=;
        b=zanKF7lyOvkharaeUTFPy2lerI07wC3H73um8rrjwz4x29twTODglOs2mnjjHDdw5g
         39X2lAT7omnrdqx3S//74/hfbyzSnEUG+BtIgU3Dme9vtqSxS50VyiPolBt67nhkhX6W
         tWyqCSq9JqqHOniNAxx+O+YFp5pTyN3Ot4MuHj0X8v3CeVqHI93it5DGDrxsamPcgLA2
         PNSUeFPkHGxPuGVO9dmDTnFb31kdEO3hcybJ+uyqwdT2pyogVQ6yRJ5uDRnZSUvwCWXj
         NL6EQkS3HFNj7kkHqcs6wqS8kYjFq1jcVRDeFyGXF4kVeGmfq4FiaKfpj6/8OqG2I2p1
         ISKg==
X-Received: by 10.152.44.164 with SMTP id f4mr154587lam.38.1378276608034; Tue,
 03 Sep 2013 23:36:48 -0700 (PDT)
Received: by 10.112.150.162 with HTTP; Tue, 3 Sep 2013 23:36:47 -0700 (PDT)
In-Reply-To: <xmqq8uzdplqv.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233809>

On Wed, Sep 4, 2013 at 6:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I do not care too deeply either way, but I am curious if there was a
> reason why you changed the earlier <directory> to <path>?  Somehow,
> when we _know_ a path has to be a directory, I find it easier on the
> readers to spell that out, instead of saying "this is a path",
> implying that it could be a directory, a regular file, or even
> non-existent.

Eric made me do it :). Personally I prefer the non-ambiguous "directory"
over "path". In fact, "directory" is used in the error message spat out
by git:

    $ git --work-tree
    No directory given for --work-tree.
    ...

    $ git --git-dir
    No directory given for --git-dir.
    ...
    $

I think changing "<path>" to "<directory>" wherever appropriate in
git.txt would be an improvement. Tangent: <dir> is shorter but that
might not be easy on the translators.

>> +-C <path>::
>> +     Run as if git was started in <path> instead of the current working
>> +     directory.  When multiple -C options are given, each subsequent
>> +     non-absolute "-C <path>" is interpreted relative to the preceding "-C
>> +     <path>".
>> +
>> +     This option affects options that expect path name like --git-dir and
>> +     --work-tree in that their interpretations of the path names would be
>> +     made relative to the working directory caused by the -C option. For
>> +     example the following invocations are equivalent:
>> +
>> +         git --git-dir=a.git --work-tree=b -C c status
>> +         git --git-dir=c/a.git --work-tree=c/b status
>> +
>
> Does the above format correctly without the usual "second and
> subsequent paragraphs are not indented, but has '+' in place of
> a blank line"?

No it doesn't. I'll fix it in the next reroll.

>> -             if (!prefixcmp(cmd, "--exec-path")) {
>> +             if (!strcmp(cmd, "-C")) {
>> +                     if (*argc < 2) {
>> +                             fprintf(stderr, "No directory given for -C.\n" );
>> +                             usage(git_usage_string);
>> +                     }
>> +                     if (chdir((*argv)[1]))
>> +                             die_errno("Cannot change to '%s'", (*argv)[1]);
>> +                     if (envchanged)
>> +                             *envchanged = 1;
>> +                     (*argv)++;
>> +                     (*argc)--;
>> +             } else if (!prefixcmp(cmd, "--exec-path")) {
>
> We usually do not prepend to an existing if/else if/ chain unless
> there is a very good reason (e.g. the new "if" condition is very
> often triggered and we are better off checking it early) exactly
> because doing so would make a patch that is ugly like the above.
> You are not touching the codepath that deal with --exec-path, but
> the resulting patch makes it appear as if you are doing something to
> it.

I agree with you here. I'll send the reroll later.

nazri
