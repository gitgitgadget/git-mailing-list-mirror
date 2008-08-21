From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] * remote.c (valid_fetch_refspec): remove useless if-before-free
 test
Date: Wed, 20 Aug 2008 19:33:11 -0500
Message-ID: <aS-Yl0OfC9_Ks79Dz2qAKZMrGX1F6_mTNtSFuB45LyarCC5Zmb8agA@cipher.nrlssc.navy.mil>
References: <87k5ecx2pl.fsf@rho.meyering.net> <pI8EXbuWhkm4pM0AaaTAPQQYBeFSffOSzCiM4NfNHKomivEcfUfShA@cipher.nrlssc.navy.mil> <7vr68jmdd2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jim Meyering <meyering@redhat.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 03:31:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVz0r-0007zB-2S
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 03:30:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752402AbYHUB3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 21:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752412AbYHUB3w
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 21:29:52 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:46287 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362AbYHUB3w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 21:29:52 -0400
Received: by mail.nrlssc.navy.mil id m7L1TOib003127; Wed, 20 Aug 2008 20:29:24 -0500
In-Reply-To: <7vr68jmdd2.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 21 Aug 2008 00:33:12.0343 (UTC) FILETIME=[7E3DEA70:01C90325]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93084>

Junio C Hamano wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
> 
>> Maybe we should also begin the process of not leaking memory here...
>>
>> diff --git a/remote.c b/remote.c
>> index 7f2897b..984ad1b 100644
>> --- a/remote.c
>> +++ b/remote.c
>> @@ -449,6 +449,20 @@ static int verify_refname(char *name, int is_glob)
>> 	return result;
>>  }
>>  
>> +void free_refspecs(struct refspec *refspec, int nr_refspec)
>> +{
>> +	int i;
>> +
>> +	if (!refspec)
>> +		return;
>> +
>> +	for (i = 0; i < nr_refspec; i++) {
>> +		free(refspec[i].src);
>> +		free(refspec[i].dst);
>> +	}
>> +	free(refspec);
>> +}
> 
> Are you sure all the codepaths that stuff refspec[].{src,dst} give
> freeable pointer?

remote.c:parse_refspec_internal() always does. This function is the
producer of the refspec that is being passed to free_refspecs() in the two
places where the patch called it.

The code paths for each additionally use of free_refspecs would have to
check that it is safe. Perhaps a comment is in order.

If you don't think we're ready for free_refspecs we can still call free()
manually in the two places I called free_refspecs.

-brandon
