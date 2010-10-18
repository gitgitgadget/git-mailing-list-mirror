From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 15/15] daemon: opt-out on features that require posix
Date: Mon, 18 Oct 2010 11:31:34 -0500
Message-ID: <20101018163134.GA6343@burratino>
References: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
 <1286833829-5116-16-git-send-email-kusmabite@gmail.com>
 <7vhbgphf25.fsf@alter.siamese.dyndns.org>
 <AANLkTi=N+4QokkiGmN+S17=7=QsgKWUXrsF0vZ_6Zt2H@mail.gmail.com>
 <7vbp6vduly.fsf@alter.siamese.dyndns.org>
 <AANLkTim0KeW3eDHAsxrxMCvBUD_15R3VSrHSzOFq38A1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysgit@googlegroups.com, j6t@kdbg.org, avarab@gmail.com,
	sunshine@sunshineco.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 18:35:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7sgT-00017N-P0
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 18:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755237Ab0JRQfb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 12:35:31 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59103 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039Ab0JRQfa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 12:35:30 -0400
Received: by wyb28 with SMTP id 28so1458332wyb.19
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 09:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=MCmbxstnezDj4wJq7eiAH8urE5OH8zM09TubNY6HhF0=;
        b=dTMuZyiutmyCy33buwzdljWPWEBb35cs46o3jSOqAdT1AQEprcFFgAEiyVf9ov4F+8
         bDJOskgVAgH97QhlRY2bCfvxCewk4C4UAYQMFyjKwKOO1xSVuzYtvqn99Y49ASwk5AEt
         IDd5oPmnaKJQH5olkpa+5qLUmZLVaLi1Eoe/I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=boQ06FItP7BYL1RZqxZ6CwTwHh5248X+6Gt2R6wyVQQjud9cH11MqIsYYbUE7GhIMU
         eAM23N+lqiK3RnLErh9DVKMz/EVleDfqT7LPCD9vxBprSLu0qejDG3HvS6YI9VVAk2wi
         6nh2bBN1gvPpM5iiy2As42pOQYo7FGecqyEqA=
Received: by 10.216.158.18 with SMTP id p18mr5526839wek.2.1287419728818;
        Mon, 18 Oct 2010 09:35:28 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id o43sm7378591weq.23.2010.10.18.09.35.25
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 18 Oct 2010 09:35:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTim0KeW3eDHAsxrxMCvBUD_15R3VSrHSzOFq38A1@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159261>

Hi,

A response to the general questions.

Erik Faye-Lund wrote:
> On Fri, Oct 15, 2010 at 11:16 PM, Junio C Hamano <gitster@pobox.com> wrote:

>> Why does the signature even have to be different between the two to begin
>> with? I _think_ you have gid_t over there
>
> We don't, so this is the primary reason.

Just to throw an idea out: you can also do something like

#ifndef NO_POSIX_GOODIES
struct credentials {
};
#else
struct credentials {
	struct passwd *pass;
	gid_t gid;
}
#endif

and pass a pointer to credentials around.

> But also avoiding
> compilation-warnings is a secondary motivation.

(void) gid;

works for this.

> We do, so this becomes a bit of a hypothetical question. But would you
> seriously consider pretending to have a posix-feature less ugly than
> inlining a function that is only used once?

In general, yes.

Long functions can make code much, much more difficult to read.  A
fake posix feature just requires some suspension of disbelief.

In this case (#ifdef-heavy main() vs opaque struct passwd), both
strike me as ugly.

> (I'm going a little off-topic here, I hope that's OK)
> I'm not too happy with some of the
> pretend-really-hard-to-be-posix-magic around in the Windows-port. In
> fact, I have some patches to reduce posixness in some areas, while
> getting rid of some code in mingw.c. Would such patches be welcome, or
> is pretend-to-be-posix the governing portability approach? In some
> cases, this comes at the expense of some performance (and quite a bit
> of added cludge), which is a bit contradictory to the Git design IMO.

Sometimes the best abstraction is the posix one and sometimes not.  I
don't think this would contradict with your planned patches, unless
they introduce #ifdefs all over the place.

>> This is especially
>> true if you are making the "drop-privileges" part a helper function, no?
>
> I don't follow this part. What exactly becomes more true by having a
> drop-privileges function?

(See linux-2.6.git:Documentation/SubmittingPatches, section "#ifdefs
are ugly".)

The ideal: never an #ifdef within a function.  (Well, the ideal is
no #ifdef-s in .c files, but that's harder to take seriously.)

#ifndef HAVE_POSIX_GOODIES
static int drop_privileges(...)
{
	return error("--user and --group not supported on this platform");
}
#endif
static int drop_privileges(...)
{
	...
	do
	something
	...
}
#endif

would make serve() look like

static int serve(...)
{
	int socknum, *socklist;

	... setup socket ...

	if (want to drop privileges) {
		if (drop_privileges(...))
			return -1;
	}

	return service_loop(socknum, socklist);
}

which should be quite readable even to a person only interested in the
!HAVE_POSIX_GOODIES case imho.  With some code rearrangement it could
be made nicer.  Now compare:

static int serve(...)
{
	int socknum, *socklist;

	... setup socket ...

#ifdef HAVE_POSIX_GOODIES
	...
	do
	things
	...
#endif

	return service_loop(socknum, socklist);
}

Just my two cents.  Sorry I do not have something more substantive to
say.
