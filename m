From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 41/44] refs.c: add a new flag for transaction delete
 for refs we know are packed only
Date: Fri, 23 May 2014 11:24:29 -0700
Message-ID: <20140523182429.GD12314@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-42-git-send-email-sahlberg@google.com>
 <20140522181722.GT12314@google.com>
 <CAL=YDWkUa2Ut=1iaMXgnjgte6g5jvXR49LBiEUNEkwv4Z-wO_w@mail.gmail.com>
 <CAL=YDW=hytDiz5qzAMyBgXUgza+AcDhk_y3m3kAUmOdBG=F=vA@mail.gmail.com>
 <20140522234440.GA12314@google.com>
 <20140522235351.GB12314@google.com>
 <CAL=YDWnRkwX3dCv9dyZmBdh2ZV7aSUCS=F6w67gJuBmCzGGBwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Fri May 23 20:24:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wnu8z-00007i-Lj
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 20:24:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbaEWSYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 14:24:33 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:53881 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971AbaEWSYc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 14:24:32 -0400
Received: by mail-pb0-f47.google.com with SMTP id rp16so4509000pbb.34
        for <git@vger.kernel.org>; Fri, 23 May 2014 11:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=myDAPNR+HXUmwFnkr9dgEyRekQL+l8d4Vf0mFG+hkQc=;
        b=zsjjM7G+cSiYrpCxkh6sCFyWpbbvTwU6B5tCxErD+LUBZaCxswmD83tVS9tbQJLH3N
         EfLeOlRK80UMn91aXzB1OikWpuzszZ2KoxoOmUtitVO7aplfwB6lVMmiBR+2c6wkkWQF
         OYm8qvLClSeSJFTYIlgo5ZIvW0ZKwRELe3j4H6rg8NdYJnKOkaVgzSu+mHAsE/3ke4LO
         Gp9IqKDgX8zJcmeqlbPVOk2um/zBixNc6WI94DWYuEXUZ7S45/btesP+SVgR6cGqcqfq
         XFTI006EkQa7KV/OJlM2Z8b828aohbrfFlcQ9GIt6zvlZHO1GkYMr6lAAEvei0zD+/oh
         d1xA==
X-Received: by 10.68.192.106 with SMTP id hf10mr8286219pbc.30.1400869472270;
        Fri, 23 May 2014 11:24:32 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id cz3sm5752899pbc.9.2014.05.23.11.24.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 23 May 2014 11:24:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAL=YDWnRkwX3dCv9dyZmBdh2ZV7aSUCS=F6w67gJuBmCzGGBwQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250008>

Ronnie Sahlberg wrote:
> On Thu, May 22, 2014 at 4:53 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> ... or is the problem that the reflogs conflict?
>>
>> How does rename_ref handle propagating the reflog from the old
>> name to the new name, by the way?
>
> I haven't touched that yet, but we can fix it after the next series
> when we have transaction support for reflogs.
>
> It still renames the reflog via the magic name
> #define TMP_RENAMED_LOG  "logs/refs/.tmp-renamed-log"

Okay, after looking at what "git branch -m" currently does (deletes
the old ref and creates the new one in separate transactions), I'm
convinced that this take-locks-for-a-shorter-period-than-is-necessary
trick is an improvement relative to the status quo.  It gets rid of
the window with objects unreferenced between the ref deletion and ref
creation, which is a nice improvement.

I still haven't looked closely at the details of the code change but
the idea looks sane as a first step.

Later we can try to get the semantics right for this kind of
delete/create pair in general transactions, if someone is interested.
:)  No need for the perfect to be the enemy of the good in the
meantime.

Thanks,
Jonathan
