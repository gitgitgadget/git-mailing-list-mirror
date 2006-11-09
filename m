X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: protect blob and diff output lines from controls.
Date: Thu, 9 Nov 2006 01:46:25 +0100
Message-ID: <200611090146.25306.jnareb@gmail.com>
References: <7vpsbxqzre.fsf@assigned-by-dhcp.cox.net> <200611090104.32247.jnareb@gmail.com> <7v1wodqxux.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 9 Nov 2006 00:45:47 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=saRbvTeSiXdL5XztvB9DvggWHSt1eUqH+y2uxig4CgQGFHmkD0C+M6iVxORLyLCml5ocaYq86QCoUXEjr8epUUIwVex6pqPp5mQSPaxqiiw6lWWxp0UAsR7ODxAwbG0U08pCoKzQUVW11iyDN6f4G9JaUO/fx4aeo7s4VN8IYnQ=
User-Agent: KMail/1.9.3
In-Reply-To: <7v1wodqxux.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31172>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ghy34-0002zz-7z for gcvg-git@gmane.org; Thu, 09 Nov
 2006 01:45:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422810AbWKIApi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 19:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423960AbWKIApi
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 19:45:38 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:44374 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1422810AbWKIAph
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 19:45:37 -0500
Received: by ug-out-1314.google.com with SMTP id m3so75692ugc for
 <git@vger.kernel.org>; Wed, 08 Nov 2006 16:45:36 -0800 (PST)
Received: by 10.66.243.4 with SMTP id q4mr431503ugh.1163033135822; Wed, 08
 Nov 2006 16:45:35 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id b23sm90878ugd.2006.11.08.16.45.35; Wed, 08 Nov
 2006 16:45:35 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> 1. First, esc_path should _not_ use subroutine which does it's own 
>> contol characters escaping. That was also a mistake I made in my patch.
>> Perhaps we should have some quot_html or to_html subroutine which does 
>> _only_ to_utf8 (decode from Encode module), escapeHTML and optionally 
>> s/ /&nbsp;/g conversion.
> 
> I hated that original arrangement, 

What did you hate, again?

>                                    but I do not see anything 
> obviously wrong in the output with the patch you are responding
> to.  Except that git_blame2 is missing a chomp() on "my $data"
> after finishing the metainfo loop, that is.

The original (mine) code for esc_path uses esc_html, which did it's
own partial (very partial) special characters esaping, namely
\014 (\f) => ^L, \033 (\e) => ^[. So if pathname had form feed character,
it would be replaced by ^L, not '\f'.

You have added quot_cec to esc_html subroutine directly. I don't know
what is your version of esc_html after the changes you made, but
this makes escaping part (quot) in esc_path never invoked. 

>> 2. In my opinion CS is better than CEC for quoting/escaping control 
>> characters in the "bulk" output, namely "blob" output and "text 
>> diff" (patchset body) output. CEC is better for pathnames (which must 
>> fit in one line), and perhaps other one-liners; perhaps not.
> 
> I am more for code reuse and consistency.  If "^L" is more
> readable then we should consistently use it for both contents
> and pathnames.  

Well, the pathname has the limit that it must be in single line
after quoting. The "blob" output is multipage. IMHO CEC like \n, \f,
\t are better in pathnames because this is what ls uses, while CS
for "blob" output is better because editors (including one true
editor being GNU Emacs ;-) uses CS like ^L (there is no end-of-line
as we split on LF and chomp; there is no tab character because line
is untabified first). But that is my opinion.

I think that conrol characters in filenames (in esc_path) should
be encompassed with <span class="cntrl">...</span> and styled.
I'm not sure if in "blob" view they should be styled. For sure
there should be no <span>...</span> for escaped attributed (future
esc_attr). Common to_html/quot_html would give us code reuse (as gives
quot_cec), if not consistent.

>                One of my tests were a symlink that points at a 
> funny filename ;-).

This should be IMHO solved rather by better "tree" view support
for symlinks, 'symlink' -> 'target' like in ls -l output.

>> BTW. what had happened with to_qtext post?
> 
> Sorry, I don't recall.

There was quite a bit of discussion about name of _suggested_
filename in blob_plain, blobdiff_plain view, namely the 
  -content_disposition => 'inline; filename="' ...
HTTP header. The result (probably lost in the noise) was to
add to_qtext subroutine for that.

Time to go to sleep...
-- 
Jakub Narebski
