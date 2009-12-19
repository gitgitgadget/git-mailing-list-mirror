From: Eric Blake <ebb9@byu.net>
Subject: Re: [PATCHv2] am: fix patch format detection for Thunderbird "Save
 As" emails
Date: Fri, 18 Dec 2009 22:38:27 -0700
Message-ID: <4B2C66D3.1070508@byu.net>
References: <7vtyvpcf36.fsf@alter.siamese.dyndns.org>  <1261172078-9174-1-git-send-email-bebarino@gmail.com>  <loom.20091218T223918-175@post.gmane.org> <1261173577.14059.5.camel@swboyd-laptop> <loom.20091218T234129-280@post.gmane.org> <4B2C395A.6080300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 19 06:38:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLs1L-0006dx-V1
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 06:38:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbZLSFiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 00:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbZLSFiW
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 00:38:22 -0500
Received: from qmta04.emeryville.ca.mail.comcast.net ([76.96.30.40]:37125 "EHLO
	QMTA04.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750828AbZLSFiW (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Dec 2009 00:38:22 -0500
Received: from OMTA23.emeryville.ca.mail.comcast.net ([76.96.30.90])
	by QMTA04.emeryville.ca.mail.comcast.net with comcast
	id JtYG1d0041wfjNsA4teN4h; Sat, 19 Dec 2009 05:38:22 +0000
Received: from [192.168.0.104] ([24.10.244.244])
	by OMTA23.emeryville.ca.mail.comcast.net with comcast
	id JtfJ1d00B5H651C8jtfKDR; Sat, 19 Dec 2009 05:39:21 +0000
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
In-Reply-To: <4B2C395A.6080300@gmail.com>
X-Enigmail-Version: 0.96.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135463>

According to Stephen Boyd on 12/18/2009 7:24 PM:
>> Nope.  You need either "\\015\\n" or '\015\n', since "\015" and "\n"
>> are both
>> undefined in portable shell.
> 
> So, how about this?
> 
>         {
>                 echo "X-Fake-Field: Line One"&&
>                 echo "X-Fake-Field: Line Two"&&
>                 echo "X-Fake-Field: Line Three"&&
>                 git format-patch --stdout first | sed -e "1d"
>         } | sed -e "s/$/;/" | tr "'";"'" "'"\015"'">  patch1-crlf.eml

Syntax error.  "$/" is not defined, so the argument to sed is not
portable.  Then, following the tr, you have an unquoted ;, meaning you
invoked 'tr "'"', followed by invoking the (non-existent) command '.

> 
> Or maybe this?
> 
>         {
>                 echo "X-Fake-Field: Line One"&&
>                 echo "X-Fake-Field: Line Two"&&
>                 echo "X-Fake-Field: Line Three"&&
>                 git format-patch --stdout first | sed -e "1d"
>         } | sed -e "s/$/;/" | tr ";" "\\015">  patch1-crlf.eml

Closer, but not there yet.  "$/" is still not defined.  Then, as a matter
of style, '\' is more readable than "\\" for representing a backslash.  So
as long as we are shifting to '', we might as well do it everywhere in
that line - write it like this:

} | sed -e 's/$/;/' | tr ';' '\015' > patch1-crlf.eml

and you should be set.

-- 
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
