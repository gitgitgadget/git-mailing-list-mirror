From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC 0/2] Re: [PATCH 2/7] Change canonicalize_url() to use the
 SVN 1.7 API when available.
Date: Sun, 14 Oct 2012 04:42:34 -0700
Message-ID: <20121014114234.GA18127@elie.Belkin>
References: <1343468312-72024-1-git-send-email-schwern@pobox.com>
 <1343468312-72024-3-git-send-email-schwern@pobox.com>
 <20120728135018.GB9715@burratino>
 <50143700.80900@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael G Schwern <schwern@pobox.com>, git@vger.kernel.org,
	gitster@pobox.com, robbat2@gentoo.org, bwalton@artsci.utoronto.ca
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Oct 14 13:43:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNMaw-0000eK-IU
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 13:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535Ab2JNLms (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 07:42:48 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:38611 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288Ab2JNLmr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 07:42:47 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so4047989pad.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 04:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=4jpeVG4Cw0R6coi1hh3XNvCKoX7nldsO7yXJAlSXMsM=;
        b=xX1UPxJRb4D6yfisW1Usn+cHXaCyfMekSagARnaVpM7EaAYQ7BsGYQMyrN2wrHmELj
         eFTzjdzIFVJt2iriy0HqPAJLvcbGDs9ryNgYwouZEqM9OcuFzlExaoOyBIVW2i76MtXE
         KLQtoYLDYy9HVJZqEqT+rYw61JMenLdFUY5eArhJ8sx9UjeXcMrlp0Qn1lQIz7WNxLWW
         4gcJRAK3hI19OFVPTMxp6QcPzE8POyQSJ8LMYQv+oitNEYgN8xy9oeUGEt+g1SEpHnjL
         ziGyoTXcL9ifMzOKTES15wlSpUZoqZGO25b7cWz9+Rf7ceTvfRYUeCkzvXAV5JOtVMzk
         X/Rw==
Received: by 10.66.75.132 with SMTP id c4mr25084826paw.2.1350214967073;
        Sun, 14 Oct 2012 04:42:47 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id kn8sm4604015pbc.24.2012.10.14.04.42.45
        (version=SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 04:42:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <50143700.80900@pobox.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207653>

Hi Eric,

Michael G Schwern wrote:
> On 2012.7.28 6:50 AM, Jonathan Nieder wrote:
>> Michael G Schwern wrote:

>>> --- a/perl/Git/SVN/Utils.pm
>>> +++ b/perl/Git/SVN/Utils.pm
>> [...]
>>> @@ -100,6 +102,20 @@ API as a URL.
>>>  =cut
>>>  
>>>  sub canonicalize_url {
>>> +	my $url = shift;
>>> +
>>> +	# The 1.7 way to do it
>>> +	if ( defined &SVN::_Core::svn_uri_canonicalize ) {
>>> +		return SVN::_Core::svn_uri_canonicalize($url);
>>> +	}
>>> +	# There wasn't a 1.6 way to do it, so we do it ourself.
>>> +	else {
>>> +		return _canonicalize_url_ourselves($url);
[...]
>> Leaves me a bit nervous.
>
> As it should, SVN dumped a mess on us.

Here's a pair of patches that address some of the bugs I was alluding
to.  Patch 1 makes _canonicalize_url_ourselves() match Subversion's
own canonicalization behavior more closely, though even with that
patch it still does not meet Subversion's requirements perfectly
(e.g., "%ab" is not canonicalized to "%AB").  Patch 2 makes that not
matter by using svn_path_canonicalize() when possible, which is the
standard way to do this kind of thing.

Sorry for the lack of clarity before.

Jonathan Nieder (2):
  git svn: do not overescape URLs (fallback case)
  Git::SVN::Utils::canonicalize_url: use svn_path_canonicalize when
    available

 perl/Git/SVN/Utils.pm | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)
