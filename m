From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: Re: problem using jgit
Date: Fri, 25 Jul 2008 16:51:58 +0200
Message-ID: <4889E88E.8000701@gmail.com>
References: <p06240809c4a9d887fda4@[192.168.1.106]> <488467E3.7000107@gmail.com> <488482A2.4000601@gmail.com> <20080722165831.GA11173@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Stephen Bannasch <stephen.bannasch@deanbrook.org>,
	git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 25 16:53:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMOfM-0001Rt-Uh
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 16:53:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbYGYOwG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 10:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbYGYOwG
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 10:52:06 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:43647 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbYGYOwE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 10:52:04 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1260158nfc.21
        for <git@vger.kernel.org>; Fri, 25 Jul 2008 07:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=PhK2CwTqyArbnlcDo9pO8c/7YJVFE2HIaFvfPOGyilo=;
        b=FTPPtKhlWLbv6ku+gLK5V+XZuRBShzXhfPVKVns5Hcqw9sHBzk7n5nKWC2ymd4Q+D3
         ogtH3etNYXAFSqBlmYHf9d1Wp7s1ZRFIFqxysbDnmNYdRFHCmUJMoau7z2u788wKvJ2Y
         Li1O+N5kvAjXalCluMvA9HCXFprrVoO+BOITc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=VlBvv/MNBwepsVnP9GWledGR94h4+M63ESMwvFB1Y0UNOPYl9rd2IAr3R1ZfLox9g9
         qUz17otN4SZmYmp+y2wBBEJXtvKUN0c2dyevHQXu6tIZfYeP5SPEyFROvRKYi7W8ywZW
         1FwGK/znd0QnkVbwEeC5hkvsc7XkdgRfj/88I=
Received: by 10.210.50.6 with SMTP id x6mr2063041ebx.87.1216997521748;
        Fri, 25 Jul 2008 07:52:01 -0700 (PDT)
Received: from ?192.168.1.167? ( [150.254.6.130])
        by mx.google.com with ESMTPS id d27sm8867919nfh.37.2008.07.25.07.52.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 25 Jul 2008 07:52:00 -0700 (PDT)
User-Agent: Mozilla-Thunderbird 2.0.0.14 (X11/20080509)
In-Reply-To: <20080722165831.GA11173@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90055>

Shawn O. Pearce wrote:
> Marek Zawirski <marek.zawirski@gmail.com> wrote:
>   
>> Marek Zawirski wrote:
>>     
>>> Stephen Bannasch wrote:
>>>       
>>>> I've setup a simple test class that integrates jgit to clone a git  
>>>> repository. However I'm getting a NullPointerError when  
>>>> RevWalk.parseAny ends up producing a null object id.
>>>>         
> ...
>   
>> It's caused by 14a630c3: Cached modification times for symbolic refs too
>> Changes introduced by this patch made Repository#getAllRefs() including  
>> Ref objects with null ObjectId in case of unresolvable (invalid?) HEAD  
>> symbolic ref, and null Ref for HEAD  when it doesn't exist. Previous  
>> behavior was just not including such refs in result.
>>     
>
> My intention here was that if a ref cannot be resolved, it should
> not be reported.  So Ref.getObjectId should never return null, and
> it should also never return an ObjectId for which the object does
> not exist in the Repository's object database(s).  (Though that can
> happen in the face of repository corruption, but lets not go there
> just yet).
>
> So IMHO the RefDatabase code is _wrong_ for returning HEAD with a
> null objectId.
>
> Now this case can happen if HEAD points at a stillborn branch.  This
> is easily reproduced in any repository, e.g. just do:
>
> 	git symbolic-ref HEAD refs/heads/`date`
>
> You'll wind up on a branch which doesn't exist.  In this case HEAD
> shouldn't be reported back from RefDatabase, it doesn't exist, as
> branch `date` does not exist either.
>
>   
Beside of my temporary fix for that that filters null Ref and Ref with 
null objectId, I think that 2 more issues may need to be resolved:

1) readRefBasic() method is used for reading arbitrary refs, potentially 
not only those from well-known prefixes as readRefs() does. Is calling 
setModified()  appropriate for those other refs?

2) Am I wrong that setModified() is not called in all cases? Consider 
empty ref file and just...
if (line == null || line.length() == 0)
            return new Ref(Ref.Storage.LOOSE, name, null);
