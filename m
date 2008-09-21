From: "Anatol Pomozov" <anatol.pomozov@gmail.com>
Subject: Re: Re* [RFC/PATCH] extend meaning of "--root" option to index comparisons
Date: Sun, 21 Sep 2008 08:58:30 -0700
Message-ID: <3665a1a00809210858r1c494d22p77b5e9964c06424e@mail.gmail.com>
References: <3665a1a00809151301p7d8e6387g3cacfb879b45da2f@mail.gmail.com>
	 <bd6139dc0809151411p49f5adeaq4beff452574ca980@mail.gmail.com>
	 <20080915223442.GD20677@sigill.intra.peff.net>
	 <bd6139dc0809152319m31a79877h5dc1b701a8210802@mail.gmail.com>
	 <20080916062105.GA12708@coredump.intra.peff.net>
	 <20080918092152.GA18732@coredump.intra.peff.net>
	 <3665a1a00809180931t191b5a24wd58554cdb761535@mail.gmail.com>
	 <20080919142537.GA1287@coredump.intra.peff.net>
	 <7vskrvswxp.fsf@gitster.siamese.dyndns.org>
	 <20080921135616.GA25238@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, sverre@rabbelier.nl,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 21 17:59:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhRLZ-0002uu-Na
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 17:59:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751662AbYIUP6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 11:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751637AbYIUP6d
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 11:58:33 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:2693 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494AbYIUP6c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 11:58:32 -0400
Received: by nf-out-0910.google.com with SMTP id d3so388833nfc.21
        for <git@vger.kernel.org>; Sun, 21 Sep 2008 08:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=uPaY1Rpu2fa27OvjkbbuRZbdzXzbUgKTOwM7ake7T5o=;
        b=elwsJvze/8Hl85+vEnwXOv670+gtrs+7uawjmP6dehsVgqCCnknNYS4V4yxg1KSeir
         N9cGJT4O+InNamdcI1F0kquHGWQa+eHxsFw5xZJq1efAAonkU2IyJ1Jrup+W4ATCGuFi
         GLrYnAeJTHO/t0aL7qXts5y451g3WOKj9hlaI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=fEFSh3H6XnKERkk91Jr9sWCw+7DWUz+fTXuMvuAee0UXgWoXqdTL9uSWIVrf3Ivtq0
         xDBeU7R42tL6KomrZuC9jboncuJqPGuZyei6MI9Uv11uBUxqLHuJ0qZKj5yUPLDanXvy
         JBX2jALAaVnT0lUTFANpot4OtyvHpumay+c1M=
Received: by 10.210.21.13 with SMTP id 13mr3507715ebu.4.1222012710857;
        Sun, 21 Sep 2008 08:58:30 -0700 (PDT)
Received: by 10.210.39.6 with HTTP; Sun, 21 Sep 2008 08:58:30 -0700 (PDT)
In-Reply-To: <20080921135616.GA25238@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96401>

Hi,

Jeff mostly explained what I expect from 'git log' and I agree with
him. We ('git log' 'git rev-parse' ...) should separate cases when
revision is broken (like we have a junk in the HEAD file) from the
case when "branch is not created yet" (which is part of normal
workflow).

What about following algorithm. HEAD points to ref and ref is not
created yet. Additional check could be
 a) there are no other refs
 or/and b) object database is empty

>> -     argc = setup_revisions(argc, argv, rev, "HEAD");
>> +     argc = setup_revisions(argc, argv, rev, NULL);
>> +     if (!rev->pending.nr) {
>> +             add_head_to_pending(rev);
>> +             if (!rev->pending.nr) {
>> +                     printf("No commits (yet).\n");
>> +                     exit(0);
>> +             }
>> +     }
>
> I like the idea of an improved message, but such a message should
> definitely not go to stdout; it would feed nonsense to a command like
> "git log | my_log_filter".

+1 here. By default 'git log' should not output anything in this case,
even "No commits yet". Although such message would be fine for
something like "git log --verbose"

-- 
anatol
