From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb: using quotemeta
Date: Mon, 2 Oct 2006 22:50:31 +0200
Message-ID: <200610022250.32029.jnareb@gmail.com>
References: <20061002201256.89409.qmail@web31809.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 02 22:50:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUUjy-0004ZX-9j
	for gcvg-git@gmane.org; Mon, 02 Oct 2006 22:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965096AbWJBUuN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Oct 2006 16:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965098AbWJBUuN
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Oct 2006 16:50:13 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:12383 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965096AbWJBUuL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Oct 2006 16:50:11 -0400
Received: by ug-out-1314.google.com with SMTP id o38so556326ugd
        for <git@vger.kernel.org>; Mon, 02 Oct 2006 13:50:09 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=FiOEJv2JN7IeQo7hn6NVW3WXAgGyB6JNT8wLBVer+cFE9rQOTl+/bf0Rkxz6hY74VIwZ1UJOlx7YTJXUYiHgqP5dLUdQaldwPKfJmIlhfyflzMdC0Q3zfxNBVr7XfVkJKtv1sCf5kw25QTZvDocHpWsqbY/EuldV89dWFv7KW6Y=
Received: by 10.66.240.12 with SMTP id n12mr3005616ugh;
        Mon, 02 Oct 2006 13:50:09 -0700 (PDT)
Received: from host-81-190-17-45.torun.mm.pl ( [81.190.17.45])
        by mx.gmail.com with ESMTP id 53sm4804917ugd.2006.10.02.13.50.08;
        Mon, 02 Oct 2006 13:50:08 -0700 (PDT)
To: Luben Tuikov <ltuikov@yahoo.com>, Junio Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <20061002201256.89409.qmail@web31809.mail.mud.yahoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28237>

Luben Tuikov wrote:
> --- Jakub Narebski <jnareb@gmail.com> wrote:
>> Luben Tuikov wrote:
>> 
>>> --- Junio C Hamano <junkio@cox.net> wrote:
>>>> 
>>>> Ouch, that was a sloppy planning and coding, and sloppier
>>>> reviewing.  Sorry.
>>>> 
>>>> What is the right quoting there?  Just quoting double-quotes?
>>> 
>>> I'm not sure.  What undesired character could we have in $filename
>>> of a snapshot?  The commit ab41dfbfd4f message gives this
>>> justification: "Just in case filename contains end of line character."
>>> 
>>> It looks like $filename is constructed by well defined strings:
>>> basename($project), $hash and $suffix all of which should be ok.
>>> 
>>> I'd say we don't need quotemeta for $filename of snapshot.
>> 
>> But we do need quoting for blob_plain and perhaps blobdiff_plain
>> views, although not quotemeta, but perhaps the reverse of unescape,
>> i.e. quote '"', EOLN (end of line) and perhaps also TAB.
> 
> Escaping for the purposes of HTML _view_ and URL generation is ok,
> but it is not ok when _saving_ the file with a file name.
> 
> A file name is just a string of chars, and I want to _save_ the file
> name as its name is. No changes or interpretations please.  I don't
> care what the string is, what chars it is made of, etc.

We need to _escape_ HTML output (using esc_html subroutine) because
HTML treats some characters specially, and we need to escape them
to turn off this interpretation. Examples include SPC (for example
file name which has two consecutive spaces) and ampersand '&' which
might be treated as entity reference.

Sometimes we want to quote filename for view, for example to fit it
in one line, and to distinguish between tab and spaces.


But you forget that in HTTP headers, to be more exact in
	Content-Disposition: inline; filename="<filename>"
header, the quote '"' and end-of-line '\n' characters in <filename>
are treated specially. So you need to quote somehow at least those
two characters.


<checks the RFC>

RFC 2616 "Hypertext Transfer Protocol -- HTTP/1.1":
   RFC 1806 [35], from which the often implemented Content-Disposition
   (see section 19.5.1) header in HTTP is derived, has a number of very
   serious security considerations. Content-Disposition is not part of
   the HTTP standard, but since it is widely implemented, we are
   documenting its use and risks for implementors. See RFC 2183 [49]
   (which updates RFC 1806) for details.

RFC 2183 "Communicating Presentation Information in Internet Messages:
          The Content-Disposition Header Field":
2.3  The Filename Parameter

   The sender may want to suggest a filename to be used if the entity is
   detached and stored in a separate file. If the receiving MUA writes
   the entity to a file, the suggested filename should be used as a
   basis for the actual filename, where possible.

   It is important that the receiving MUA not blindly use the suggested
   filename.  The suggested filename SHOULD be checked (and possibly
   changed) to see that it conforms to local filesystem conventions,
   does not overwrite an existing file, and does not present a security
   problem (see Security Considerations below).

   The receiving MUA SHOULD NOT respect any directory path information
   that may seem to be present in the filename parameter.  The filename
   should be treated as a terminal component only.  Portable
   specification of directory paths might possibly be done in the future
   via a separate Content-Disposition parameter, but no provision is
   made for it in this draft.

   Current [RFC 2045] grammar restricts parameter values (and hence
   Content-Disposition filenames) to US-ASCII.  We recognize the great
   desirability of allowing arbitrary character sets in filenames, but
   it is beyond the scope of this document to define the necessary
   mechanisms.  We expect that the basic [RFC 1521] `value'
   specification will someday be amended to allow use of non-US-ASCII
   characters, at which time the same mechanism should be used in the
   Content-Disposition filename parameter.

> Please don't interpret file names and their characters when the files
> are _saved_ by the user's browser.
>
> The file name in my filesystem should be the exact same file name
> as it appears on any other filesystem hosting the same git repo.

As you can see from the above RFC, there is no standard way to pass
suggested filename to be exactly the same as in git repository, if
it contains non US-ASCII characters. At least not for _HTTP_ 
Content-Disposition: header; for email we can use quoted-printable
from RFC 2047 to encode non US-ASCII characters (including " and EOLN)
with good probability of this working correctly.
 
> I don't want this translation:
> Server FS: linux-2.6.git-5c2d97cb31fb77981797fec46230ca005b865799.tar.gz
> Quotemeta: linux\-2\.6\.git\-5c2d97cb31fb77981797fec46230ca005b865799\.tar\.gz
> User FS: linux\-2\.6\.git\-5c2d97cb31fb77981797fec46230ca005b865799\.tar\.gz
> 
> When you comitted ab41dfbfd4f3f9fedac71550027e9813b11abe3d, it extended
> quotemeta to where it shouldn't have been applied.

I only followed (I admit blindly, without checking the details, and
I agree wrongly) the commit a2f3db2f5de2a3667b0e038aa65e3e097e642e7d
   "gitweb: Consolidate escaping/validation of query string"
by Petr "Pasky" Baudis, which among others included the following patch
(which part of commit is not documented enough in commit message):

@@ -3126,7 +3116,7 @@ sub git_blobdiff {
 			-type => 'text/plain',
 			-charset => 'utf-8',
 			-expires => $expires,
-			-content_disposition => qq(inline; filename="${file_name}.patch"));
+			-content_disposition => qq(inline; filename=") . quotemeta($file_name) . qq(.patch"));
 
 		print "X-Git-Url: " . $cgi->self_url() . "\n\n";
 

And I agree that your
   "gitweb: Don't use quotemeta on internally generated strings"
is (partially) correct.

>     Luben
> P.S. When replying please don't redact the CC field.

When I reply by email, I have no problem (I have to add git
mailing list if I forget to use reply to all). When I reply
via GMane NNTP interface, KNode by default replies only to
newsgroup (coupled with git mailing list).
-- 
Jakub Narebski
Poland
