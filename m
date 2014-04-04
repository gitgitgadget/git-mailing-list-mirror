From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Patch Series v3 for "use the $( ... ) construct for command
 substitution"
Date: Fri, 4 Apr 2014 11:12:15 -0700
Message-ID: <20140404181215.GJ6851@google.com>
References: <CA+EOSBkF+hLOab0oJH7HuUb_KKn+1sgV_Lshwupgj-_yAAfmFw@mail.gmail.com>
 <20140404172946.GI6851@google.com>
 <vpqk3b56lik.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elia Pinto <gitter.spiros@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Apr 04 20:12:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WW8bJ-0004yl-0Y
	for gcvg-git-2@plane.gmane.org; Fri, 04 Apr 2014 20:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753729AbaDDSMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2014 14:12:19 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:49926 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752709AbaDDSMS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2014 14:12:18 -0400
Received: by mail-pb0-f53.google.com with SMTP id rp16so3789505pbb.40
        for <git@vger.kernel.org>; Fri, 04 Apr 2014 11:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=y6gOxR8NE5LTlqEXfmk6Ab0W5ZMCAuN1RGml+1qcfFY=;
        b=bgmaJk2CtRPJvCTgq1O6QxJhmhGCJ2VFQqwIj1tEcHth2Ah+FAwbUkc4kwotoQ/a5Q
         3Um2ReWBNmwP9uUYvFxeUejfdAtXoEUk57M5lpL4mHWh+4Iu/h1WoTpbSs72CA6BPd9R
         BT6ZlZ3r0+gEeJXO162Y0DW7mmpT8u34SVvIicUrQIjCz+dMBFhmtZYOG6Cdv+QObRba
         BzcGvmEm2uHRlwprknws92siXrX0MZy99fFj09Si1pq5lE181e3FA3S+1Y/A0uLf2R1k
         9wRdxtfrdSK26t6QujfF2ouI/xm+BGsW4fWK8h2udMxFhkl3B0H6MeAQgt9g1nkTT3dR
         k6RQ==
X-Received: by 10.67.14.98 with SMTP id ff2mr16345643pad.101.1396635138324;
        Fri, 04 Apr 2014 11:12:18 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id sv10sm11921528pbc.74.2014.04.04.11.12.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 04 Apr 2014 11:12:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <vpqk3b56lik.fsf@anie.imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245767>

Matthieu Moy wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> If the script is "obviously correct" enough then there is no need
>> to manually go through 140 files after that point.
>
> The script cannot be "obviously correct", as there are a lot of
> potential corner-cases (nested `, nesting ` within ", comments, ...).

To be a devil's advocate for a moment:

 * Comments are easy to detect.  Remember, we are not trying to handle
   some adversary sending arbitrary well-formed shell scripts but just
   the git source code which already follows a consistent style.  When
   I search for /#.*/ in .sh files, every match except for

	t/test-lib-functions.sh:output=`echo; echo "# Stderr is:"; cat "$stderr"`

   (which contains a backtick before the # mark) is a comment.

 * Nested ` is evil.  A search for the string \' quickly finds them all,
   and they are very very rare.

   The only exception I see is git-svn tests, which independently of
   everything else is an obvious thing to fix first.

 * Nesting `` within double-quotes has the same semantics as $()
   within quotes.  I don't think that poses a problem.

[...]
>> If the only way to get this done is to actually manually review those
>> 140 files, I just don't think it's worth it.
>
> Honnestly, I went through the series once and it wasn't that painful.

It is not just the people on the list reviewing now but others in the
future wanting to understand whether it is safe to upgrade to a new
version or where a bug they have run into came from.  The simpler we
can make the task of convincing oneself that the patch behaves as
described, the better.

140 patches worth of churn once every couple of years is not terrible,
but I really don't want to see this becoming a pattern. :/  And I
don't see how the upside in this example warrants it.

Hoping that clarifies,
Jonathan
