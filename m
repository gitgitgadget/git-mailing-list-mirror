From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFD] Handling of non-UTF8 data in gitweb
Date: Sun, 18 Dec 2011 23:00:58 +0100
Message-ID: <201112182300.59409.jnareb@gmail.com>
References: <201112041709.32212.jnareb@gmail.com> <7vehwhcj3q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?iso-8859-1?q?J=FCrgen_Kreileder?= <jk@blackdown.de>,
	John Hawley <warthog9@kernel.org>,
	Ismail =?iso-8859-1?q?D=F6nmez?= <ismail@pardus.org.tr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 18 23:01:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcOn8-0006Uv-DM
	for gcvg-git-2@lo.gmane.org; Sun, 18 Dec 2011 23:01:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892Ab1LRWBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Dec 2011 17:01:05 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:46037 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222Ab1LRWBD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Dec 2011 17:01:03 -0500
Received: by eekc4 with SMTP id c4so4901994eek.19
        for <git@vger.kernel.org>; Sun, 18 Dec 2011 14:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=HAzdhmwSFljNjsD+R6THlgJNLuXlv3wV9BuEWuAHIwo=;
        b=Wq+wBRIT8LhtbxebcriNDlKFFcojY49TtuuzXo/7sZgbwNAq1F1gSIIKAJA/b3z9rC
         aZPWCQ3vvJ9C4ZAHOKl9bXfTWi1zefoJVH9wC+tQLd1WnlEhRYSdL9Ua8ivImh+xxgJ5
         NOCqT6kGBLRZYSw9M1amnPdriA0rrWP0evbSg=
Received: by 10.14.15.99 with SMTP id e75mr397246eee.67.1324245662297;
        Sun, 18 Dec 2011 14:01:02 -0800 (PST)
Received: from [192.168.1.13] (aehn116.neoplus.adsl.tpnet.pl. [79.186.195.116])
        by mx.google.com with ESMTPS id z43sm35912940eef.7.2011.12.18.14.00.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Dec 2011 14:00:59 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vehwhcj3q.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187428>

On Wed, 7 Dec 2011, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > But doing this would change gitweb behavior.  Currently when 
> > encountering something (usually line of output) that is not valid 
> > UTF-8, we decode it (to UTF-8) using $fallback_encoding, by default
> > 'latin1'.  Note however that this value is per gitweb installation,
> > not per repository.
> 
> I think we added and you acked 00f429a (gitweb: Handle non UTF-8 text
> better, 2007-06-03) for a good reason, and I think the above argues that
> whatever issue the commit tried to address is a non-issue. Is it really
> true?

Actually... the change in 

  00f429a (gitweb: Handle non UTF-8 text better, 2007-06-03)

worked correctly, but since 

  e5d3de5 (gitweb: use Perl built-in utf8 function for UTF-8 decoding., 2007-12-04)

it was changed to a NON-WORKING version - and *nobody* protested.

   sub to_utf8 {
   	my $str = shift;
  -	my $res;
  -	eval { $res = decode_utf8($str, Encode::FB_CROAK); };
  -	if (defined $res) {
  -		return $res;
  +	if (utf8::valid($str)) {
  +		utf8::decode($str);
  +		return $str;
   	} else {
   		return decode($fallback_encoding, $str, Encode::FB_DEFAULT);
   	}

Well, it works for utf8 and latin1 _only_ (with $fallback_encoding being
set to 'latin1' by default), and for latin1 by historical accident... that
might be why nobody noticed.  $fallback_encoding != 'latin1' or 'utf8'
didn't work.

utf8::valid(STRING) is an internal function that tests whether STRING is
in a consistent state regarding UTF-8.  It returns true is well-formed
UTF-8 and has the UTF-8 flag on _or_ if string is held as bytes (both
these states are 'consistent').  For gitweb the second option was true.

Note that utf8:decode(STRING) returns false if STRING is invalid as UTF-8.

What makes it all work is the fact that utf8:decode(STRING) turns on UTF-8
flag only if source string is valid UTF-8 and contains multi-byte UTF-8
characters... and that if string doesn't have UTF-8 flag set it is treated
as in native Perl encoding, i.e. 'latin1' / 'iso-8859-1' (unless it is EBCDIC).
It is ':utf8' layer that actually convert 'latin1' to 'utf8'.

-- >8 --
Subject: [PATCH] gitweb: Fix fallback mode of to_utf8 subroutine

e5d3de5 (gitweb: use Perl built-in utf8 function for UTF-8 decoding.,
2007-12-04) was meant to make gitweb faster by using Perl's internals
(see subsection "Messing with Perl's Internals" in Encode(3pm) manpage)

Simple benchmark confirms that (old = 00f429a, new = this version):

        old  new
  old    -- -65%
  new  189%   --

Unfortunately it made fallback mode of to_utf8 do not work...  except
for default value 'latin1' of $fallback_encoding ('latin1' is Perl
native encoding), which is why it was not noticed for such long time.

utf8::valid(STRING) is an internal function that tests whether STRING
is in a _consistent state_ regarding UTF-8.  It returns true is
well-formed UTF-8 and has the UTF-8 flag on _*or*_ if string is held
as bytes (both these states are 'consistent').  For gitweb the second
option was true, as output from git commands is opened without ':utf8'
layer.

What made it work at all for STRING in 'latin1' encoding is the fact
that utf8:decode(STRING) turns on UTF-8 flag only if source string is
valid UTF-8 and contains multi-byte UTF-8 characters... and that if
string doesn't have UTF-8 flag set it is treated as in native Perl
encoding, i.e.  'latin1' / 'iso-8859-1' (unless native encoding it is
EBCDIC ;-)).  It was ':utf8' layer that actually converted 'latin1'
(no UTF-8 flag == native == 'latin1) to 'utf8'.


Let's make use of the fact that utf8:decode(STRING) returns false if
STRING is invalid as UTF-8 to check whether to enable fallback mode.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
I'm sorry for overly wordy commit message...

 gitweb/gitweb.perl |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d24763b..75b0970 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1443,8 +1443,7 @@ sub validate_refname {
 sub to_utf8 {
 	my $str = shift;
 	return undef unless defined $str;
-	if (utf8::valid($str)) {
-		utf8::decode($str);
+	if (utf8::valid($str) && utf8::decode($str)) {
 		return $str;
 	} else {
 		return decode($fallback_encoding, $str, Encode::FB_DEFAULT);
-- 
1.7.6
