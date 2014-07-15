From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v20 43/48] refs.c: move the check for valid refname to lock_ref_sha1_basic
Date: Tue, 15 Jul 2014 12:34:08 -0700
Message-ID: <CAL=YDWkYAg-0h3ZwiyZGtUHFEv1KEti_uURTwgbZE9xT_P_XSQ@mail.gmail.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
	<1403275409-28173-44-git-send-email-sahlberg@google.com>
	<53BC07FC.8080601@alum.mit.edu>
	<20140715180424.GJ12427@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 21:34:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X78US-0002PY-FM
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 21:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933419AbaGOTeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 15:34:11 -0400
Received: from mail-vc0-f173.google.com ([209.85.220.173]:41237 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933264AbaGOTeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 15:34:09 -0400
Received: by mail-vc0-f173.google.com with SMTP id hy10so7319653vcb.4
        for <git@vger.kernel.org>; Tue, 15 Jul 2014 12:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=QfQRiIEeoD3a9WAU6JBSGYh6uzXnNFKlx4bS8N71Zb4=;
        b=Yyq67WQAMzz2Jb0vcqdT9ffFWmpdfvzH1o4O+5Uey+TArxKh36n4CGbVKfB+fIxtBG
         FgAEmbFpQIFhNz1Qg+TvoMqS+NwJeu/1tP8VeQJuPnSQS1zrAZm/jgv47RPxJD8Z0ehY
         JrPOcWRLCuB055A7zyb6Bb/4hDGGW9yOiqXapBbJiu5osyrN8KnK1g3Sj4+pkuqslVjM
         LmkFvjye/VayADQmZYMHLpKeHx8IX2Goyx7P2SWfFnMWLBNH1rM5O/3J602KfNewdaIP
         yds+teg1CiIGyq8OdJiprSAEdo+u3qpFntE30EojIvPCgntlTwoNr4xfTwVEwvKMmRZ1
         jFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=QfQRiIEeoD3a9WAU6JBSGYh6uzXnNFKlx4bS8N71Zb4=;
        b=hPTi0xk0KkbbFjjjBHdNQG4z94uzg6kd2zjq6HMfP5MKS+/RZJkVqs9/GJQ5GzPzmx
         TvxvXjO0gLjiNs316drJSdgT+OjgvR54TYt6swUuzDDDoCcYH9HTJ0rAM3SpIENR3N7O
         SWWK7ZpFZ+jbx72VxIBd3k+QFAgD9ccs8Jc4wmsM7DMwoeAReCqUC0C8+sHQbkND2T+e
         uEXZEFZ5xrMbAJeAz+6Wh+qs8Ne/N4hEqImXRIR98mqp3b6toIGnwu/0PWoAz0pCLVR+
         zyrO/8Zx0G1wrC6XrASG+djKhB9NNrHkmUT5fI1YY9gavYByDqa1JZ71kPZ0Y4UOWK4J
         +aOQ==
X-Gm-Message-State: ALoCoQmMILUeS639srucXXVMAaca4JBhyJAxKO6aTAuqOaVlOYJHIvnS3lHp7t8Xgk0wTo47MNzt
X-Received: by 10.52.172.5 with SMTP id ay5mr7352832vdc.38.1405452848398; Tue,
 15 Jul 2014 12:34:08 -0700 (PDT)
Received: by 10.52.136.166 with HTTP; Tue, 15 Jul 2014 12:34:08 -0700 (PDT)
In-Reply-To: <20140715180424.GJ12427@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253592>

On Tue, Jul 15, 2014 at 11:04 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Michael Haggerty wrote:
>
>> So...I like the idea of enforcing refname checks at the lowest level
>> possible, but I think that the change you propose is too abrupt.  I
>> think it needs either more careful analysis showing that it won't hurt
>> anybody, or some kind of tooling or non-strict mode that people can use
>> to fix their repositories.
>
> The recovery code has been broken for a while, so I don't see harm
> in this change.
>
> How to take care of the recovery use case is another question.  FWIW I
> also would prefer if "git update-ref -d" or "git branch -D" could be
> used to delete corrupt refs instead of having to use fsck (since a
> fsck run can take a while), but that's a question for a later series.
>
> In an ideal world, the low-level functions would allow *reading* and
> *deleting* poorly named refs (even without any special flag) but not
> creating them.  Is that doable?

That should be doable. Ill add these repairs as 3-4 new patches at the
end of the current patch series.

> The main complication I can see is
> iteration: would iteration skip poorly named refs and warn, or would
> something more complicated be needed?

Right now,  "git branch"  will error and abort right away when it
finds the first bad ref. I haven't checked the exact spot it does this
yet but I suspect it is when building the ref-cache.
I will solve the cases for create and delete for now.


What/how to handle iterables will require more thought.
Right now, since these refs will be filtered out and never end up in
ref-cache, either from loose refs or from packed refs
it does mean that anyone that uses an iterator is guaranteed to only
get refs with valid names passed back to them.
We would need to audit all code that uses iterators and make sure it
can handle the case where the callback is suddenly
invoked with a bad refname.

>
> Thanks,
> Jonathan
