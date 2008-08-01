From: "Dmitry Potapov" <dpotapov@gmail.com>
Subject: Re: [PATCH] git-svn now work with crlf convertion enabled.
Date: Fri, 1 Aug 2008 16:36:54 +0400
Message-ID: <37fcd2780808010536v63b2ed2ak31c6d85f2822dc20@mail.gmail.com>
References: <200807231544.23472.litvinov2004@gmail.com>
	 <37fcd2780808010047t4ae20168y65103e90897dd3f8@mail.gmail.com>
	 <7vbq0dtawp.fsf@gitster.siamese.dyndns.org>
	 <200808011811.06984.litvinov2004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Eric Wong" <normalperson@yhbt.net>
To: "Alexander Litvinov" <litvinov2004@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 01 14:38:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOttj-00084b-4u
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 14:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758831AbYHAMg4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 08:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753651AbYHAMg4
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 08:36:56 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:52813 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776AbYHAMgz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 08:36:55 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1401393wfd.4
        for <git@vger.kernel.org>; Fri, 01 Aug 2008 05:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=6DJLS33NqZMuXf5+vDCKDv6eg8B443LdOUAUry39WcI=;
        b=d8kHUGbVFAOCsYJdQWOHVYFneobLCrTVaYAKjQVGwtPS6EbKR6Uw9TLHC4i0OvtsBX
         iOEijLB8M28JopwgUaNnwHGdoO3v/RX/PGdEgEuX82s2T0SF5/eZwXKIiZaldAd92gRe
         obCwcFYT6QiV95EAol/05/7teR/YVsa0Pq9Zk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=cgECqsnpImLg0gV8PDCOnwA/mUxYAtWdOt0msrUWq/qvHFjyWymZYQtJaBps3Th6wR
         vezltrpSjYbz8CWALilTXooqXspfQSrJ+ewJIt4lMqdjUkXngayNmvrwrhyrS5VuA9bA
         s4zIGxf/k6r+Uf9i8SuPoZzH7InxJ+8lfrYcU=
Received: by 10.142.177.5 with SMTP id z5mr3723056wfe.255.1217594214771;
        Fri, 01 Aug 2008 05:36:54 -0700 (PDT)
Received: by 10.142.106.16 with HTTP; Fri, 1 Aug 2008 05:36:54 -0700 (PDT)
In-Reply-To: <200808011811.06984.litvinov2004@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91065>

On Fri, Aug 1, 2008 at 3:11 PM, Alexander Litvinov
<litvinov2004@gmail.com> wrote:
>> To being able to synchronize efficiently in both ways, you need to store
>> files exactly as they were received from SVN then there will be no
>> problem with applying binary delta patch. All CRLF conversion should be
>> done on checkout and checkin from/to Git repository.
>
> Sorry I have lost the mind flow here.
>
> 1. We 'fetch' files from svn as is. Yes, we know that svn use delta to rebuild
> original file.
> 2. We commit file to git. Right here we use git-hash-object. As I understand
> we _have_ to do convertion CRLF->LF here.

No, you should do any conversion here. There are two reasons for that:
1. If you do then you will not be able to apply binary patches later.
2. You do not really need it if the SVN repository has correct eol settings,
because all files that have svn:eol-style set to either 'native' or 'LF'
will have LF. Those that do not have svn:eol-style or have it to another
value should not be subject to CRLF conversion at all.

So, I believe all files received from SVN should be stored as is. Import is
not about creating new commits, it is about getting history from another
repository as it is.

> 3. In some days we will checkout file from git and wil do LF->CRLF convertion.

It is done only for files that do not have CRLF already.

>
> I thought this is a right workflow.
> - We could store original file too at step 2 somwhow to be able to use delta
> at step 1.
> - We can't skip convertion at step 2. Overwise git will store files with CRLF.

It is okay for Git to store CRLF, because you want to treat them as
binary files.  If you want them being treated as text, you should change
svn:eol-style to 'native' for those files in SVN and then new versions
of these files will have the right ending. It is how SVN client works.

The only problem is how to synchronize the SVN view which files are binary
and which are text and what Git thinks about them.

Dmitry
