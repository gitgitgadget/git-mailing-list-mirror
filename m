From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] cvsserver: Make always-binary mode a config file option
Date: Wed, 28 Feb 2007 13:01:56 +0000
Message-ID: <200702281301.58026.andyparkins@gmail.com>
References: <7v4ppedj3r.fsf@assigned-by-dhcp.cox.net> <200702271345.09341.andyparkins@gmail.com> <46a038f90702280336k6d368b8aj88ce8d3d822b1789@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Martin Langhoff" <martin.langhoff@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 14:02:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMORh-00012s-Li
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 14:02:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbXB1NCJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 08:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbXB1NCI
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 08:02:08 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:37317 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932189AbXB1NCE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 08:02:04 -0500
Received: by nf-out-0910.google.com with SMTP id o25so545408nfa
        for <git@vger.kernel.org>; Wed, 28 Feb 2007 05:02:03 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=MRYVT0hde2/K6Nk+n3IiuDZvziV12eKdhHh4zx1pRXzxDYuh5HLBj7lz6wRUP2RNccnEAkcThYS+UjuqCyn/y+zXV3Ke5cUKKGmapIQdOmv+CTu0WfH8gmMiUt5TlREtGpje+04ySWDwc9CE0jEeFIyEjlYwUTdEYW/fxmFVGZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=aQUzqTrQxMAVYUbm2cc6JIeT8F0zNFDutRBaJQh08klxxtsQfH3i3tFLN+LH5d3apYHht9tasLXontMqWDRY5BI7KgKbRin6j6T0892AF7Z5IAOEb4pNPmMCtKQ7+9JgBE6Epmhqz6mYV/UJzDj0LyBsNfAH1TA32LtDQrh89dM=
Received: by 10.49.34.17 with SMTP id m17mr3505778nfj.1172667723481;
        Wed, 28 Feb 2007 05:02:03 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id n22sm5639326nfc.2007.02.28.05.02.00;
        Wed, 28 Feb 2007 05:02:01 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <46a038f90702280336k6d368b8aj88ce8d3d822b1789@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40919>

On Wednesday 2007 February 28 11:36, Martin Langhoff wrote:

> I am a bit confused here... why would we want to do this? We don't
> want to support keyword expansion, and that happens at the server end

Well, at the moment you don't, but that might happen in the future with 
certain settings in .gitattributes.  It might be nice to have a switch to 
disable that available.  However, that's not why I added this.

> anyway. CVS clients are pretty dumb and will just write out the file
> we give them. When we are going to diff, they send the file to the
> server, and the server runs the diff. Etc. No smarts at the client end
> that care about -k options.

I think your supposition that no client cares about the -k options is wrong. 
CVS clients don't just write the file untouched.  CVS stores all text files 
with UNIX line endings, the client then uses the text/binary flag to decide 
if line-ending conversion should happen.  Checking out to unix would of 
course not require any conversion so the file would be untouched.  Not so for 
Windows clients.  That was what prompted me to make this patch.  I keep some 
binary images in the git repository, when they were checked out with 
TortoiseCVS they were having all the 0x0a (LF) bytes changed to CR LF, and 
thus mangling the images.  

> Or are you trying to control newline mangling on Windows/Mac clients?
> I'm not even sure where that mangling happens. If that's the case, a

It seems to be happening in the client.  In fact it's a given that it happens 
in the client as only the client knows what the local line ending rules are.

> repo-wide toggle is useless, you really want the per-file-type rules
> you mention.

"Useless" is a strong word; especially as I'm finding it very useful :-). 

Yes, a per-file option would be better - but git has no support for that at 
present, so I need a work around.  Most windows editors will cope fine with 
UNIX line endings, so not converting them doesn't cause a problem.  On the 
other hand, mangling every binary file /does/ matter.  So, for me, the better 
default is to not mangle anything (i.e. tell CVS that everything is binary 
and should be preserved as is).


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
