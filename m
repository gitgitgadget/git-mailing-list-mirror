From: Andreas Ericsson <ae@op5.se>
Subject: Re: Supporting hashes other than SHA-1
Date: Tue, 12 May 2009 15:59:36 +0200
Message-ID: <4A0980C8.7060106@op5.se>
References: <20090511195242.GA14756@foursquare.net>	<m3zldjl5bq.fsf@localhost.localdomain> <m3vdo6lbuy.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Chris Frey <cdfrey@foursquare.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 12 15:59:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3sWI-0002by-Kp
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 15:59:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752919AbZELN7m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 09:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752687AbZELN7l
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 09:59:41 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:51036 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007AbZELN7j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 09:59:39 -0400
Received: by bwz22 with SMTP id 22so3290206bwz.37
        for <git@vger.kernel.org>; Tue, 12 May 2009 06:59:37 -0700 (PDT)
Received: by 10.86.25.10 with SMTP id 10mr7779875fgy.79.1242136777667;
        Tue, 12 May 2009 06:59:37 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id 4sm1057078fge.3.2009.05.12.06.59.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 12 May 2009 06:59:37 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <m3vdo6lbuy.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118896>

Jakub Narebski wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Chris Frey <cdfrey@foursquare.net> writes:
>>
>>> Considering the recent news regarding SHA-1's newly found weaknesses,
>>> is there any general interest in making git flexible enough to support
>>> other hashes in the future?
>> First, there isn't as far as I know any 'known preimage' attack
>> against SHA-1, and only that would truly matter for Git.
>>
>> Second, this issue was discussed in depth in the past; check git
>> mailing list archives, please...
> 
> See also this blog entry (and comments):
>   http://kitenet.net/~joey/blog/entry/sha-1/
> 

It's a bit harder than that, since both pre-images have to be the same
size. Git does this when hashing an object to the database:

static void write_sha1_file_prepare(const void *buf, unsigned long len,
                      const char *type, unsigned char *sha1,
                      char *hdr, int *hdrlen)
{
    git_SHA_CTX c;

    /* Generate the header */
    *hdrlen = sprintf(hdr, "%s %lu", type, len)+1;

    /* Sha1.. */
    git_SHA1_Init(&c);
    git_SHA1_Update(&c, hdr, *hdrlen);
    git_SHA1_Update(&c, buf, len);
    git_SHA1_Final(sha1, &c);
}

Iow, the type and, more importantly, *size* of the object is added to
the hash. AFAIK, the pre-image conflict generators all rely on being
able to manipulate the size of the content it's creating hashes for.
I don't know how hard that would be to change, so perhaps someone else
can enlighten me.

I'm not exactly overwhelmed by the attack vectors Joey describes either.
First of all, it's rather trivial to add a check to git to make it
decompress its own internal object when it receives a conflicting hash
and then check the type, size and content of both objects and alert a
user if there is a mismatch somewhere. It wouldn't even burn that much
CPU, since conflicts are extremely rare without malevolent intervention.
That would defeat the first scenario by alerting users rather promptly.

The second scenario can't really be prevented, but unless Alice is
really a server-admin on the server hosting the repository, she will
leave traces in the ssh-logs. It also relies on the build-server being
utterly stupid by re-cloning the entire project.

Neither case is exactly foolproof. Both have a high risk of exposure.
A far better and simpler thing to do (if one were so inclined) would
be to just add whatever malicious code one wants but make it appear as
if it was added in a patch-series from someone else and then hope
noone notices until it's too late. Far less risk for the same gains.

As both vectors outlined by Joey require a lot of community trust, I'm
not particularly worried.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Register now for Nordic Meet on Nagios, June 3-4 in Stockholm
 http://nordicmeetonnagios.op5.org/

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
