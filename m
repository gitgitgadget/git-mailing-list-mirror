From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/2] allow git-svn fetching to work using serf
Date: Sun, 7 Jul 2013 10:40:43 -0700
Message-ID: <20130707174043.GA9975@google.com>
References: <CB53C901-3643-46AE-AA80-CED5E20AC3B7@gmail.com>
 <51D7C47D.5070700@acm.org>
 <20130707002804.GF30132@google.com>
 <1D11122F-5C75-4FAC-80EA-D5DC65902403@gmail.com>
 <20130707013747.GM30132@google.com>
 <FBCA37F9-4988-4773-8D8D-9CB041C35289@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Rothenberger <daveroth@acm.org>, git@vger.kernel.org,
	users@subversion.apache.org
To: Kyle McKay <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 07 19:43:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvszT-00065M-Sp
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 19:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752843Ab3GGRnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 13:43:12 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:36218 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752618Ab3GGRnL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 13:43:11 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so3513991pbb.8
        for <git@vger.kernel.org>; Sun, 07 Jul 2013 10:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=6ruFApX049GXxuhAnn/0xK9jw2cqcxqZGmM7ciEdw3s=;
        b=tp6YHaqqSzHdr5H6DkSxHNXQC8/HePLPXQVu7R2xaakpY5Ltp1DDKne1mLnLEYacJY
         GZi6UHieh+68vwhhDZvyurjewSj81dV2LgJmW0wAtl4U9d/p590H2DTk/G8dUgix12ek
         Wm3sRB4AZXYG6gqI4UyWty4BQRgHxlFyYwbHUo1UZH+HOR8KdzSykFL75FSMSjQme8Do
         F68wztwKQewy0LTUC17h7Zu+w3hm1gihdRCVTEEqsu+v3Ig/lXB2wcVX/+A/PYd/3A7b
         YyRS9nj3FGzEDvOQfRBOyaK8RsuZOROR9H2StOQ00A1ffF7uoniYJd9e6GG3sup2WvrJ
         NDcg==
X-Received: by 10.68.17.169 with SMTP id p9mr18015999pbd.17.1373218990430;
        Sun, 07 Jul 2013 10:43:10 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id td4sm19451674pac.20.2013.07.07.10.43.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 07 Jul 2013 10:43:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <FBCA37F9-4988-4773-8D8D-9CB041C35289@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229783>

(cc-ing subversion's users@ list for advice)
Kyle McKay wrote:
> On Jul 6, 2013, at 18:37, Jonathan Nieder wrote:
>> Kyle McKay wrote:
>>> Begin forwarded message:

>>>> [2] http://subversion.tigris.org/issues/show_bug.cgi?id=2932
>>
>> Ah, thanks for the context.
>>
>> It's still not clear to me how we know that ra_serf driving the editor
>> in a non depth-first manner is the problem here.  Has that explanation
>> been confirmed somehow?
[...]
> Since ra_serf makes multiple connections to the server (hard-coded
> to 4 prior to svn 1.8, defaults to 4 in svn 1.8 but can be set to
> between 1 and 8) it makes sense there would be multiple active calls
> to apply_textdelta if processing is done as results are received on
> the multiple connections.

Ah, that's worrisome.  Do I understand you correctly that to work with
ra_serf in skelta mode, callers need to make their apply_textdelta
callback thread-safe?

Or do you just mean that the traversal order is based on the order in
which results are received?  That would be fine, as long as after each
apply_textdelta call, close_file is called before the next
apply_textdelta.

Jonathan
