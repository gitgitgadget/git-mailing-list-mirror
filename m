From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: [PATCH 5/6] Introduce the git fast-import-helper
Date: Sun, 03 Oct 2010 19:39:03 +0200
Message-ID: <4CA8BFB7.2050707@dbservice.com>
References: <4CA86A12.6080905@dbservice.com> <1286108511-55876-5-git-send-email-tom@dbservice.com> <20101003153144.GA18001@burratino> <4CA8A504.50009@dbservice.com> <AANLkTinZ6NCvKeALDBfP4z=ewkwWVwHBk=C_LmXM7OFh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 03 19:43:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2SbH-0000Vt-J4
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 19:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754116Ab0JCRjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 13:39:09 -0400
Received: from office.neopsis.com ([78.46.209.98]:59546 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182Ab0JCRjI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 13:39:08 -0400
X-Spam-Status: No, hits=0.0 required=5.0
	tests=BAYES_00: -1.665,TOTAL_SCORE: -1.665,autolearn=ham
X-Spam-Level: 
Received: from calvin.caurea.org ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Sun, 3 Oct 2010 19:39:04 +0200
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <AANLkTinZ6NCvKeALDBfP4z=ewkwWVwHBk=C_LmXM7OFh@mail.gmail.com>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157886>

On 10/3/10 5:53 PM, Sverre Rabbelier wrote:
>> I only need two new things from fast-import:
>>  1) support non-numeric marks (and even this is maybe not strictly
>> required)
> 
> If this can be avoided, or worked around somehow, it would be a boon
> to performance. The current marks implementation uses a hash table
> index by the mark number, which is O(1), very efficient.

I also use a hash table (struct hash_table from hash.h). It's indexed by
the atom. So it's about equally fast as the existing one but uses
slightly more memory. I measured the speed and fih is about 5% slower
than fi. Also, I found out that setting max_packfile to 32MB makes the
import much faster (from 10 minutes down to 3m to import the sources of
git itself).

>>  2) dump the mark->sha1 mapping immediately after creating the object
>> (I heard there is a patch somewhere that does just that)
> 
> Why do you need that? Wouldn't the "write created object name to
> stdout" not be sufficient?

I do: fprintf(stdout, "mark :%s %s\n", mark, sha1_to_hex(sha1));
One reason why not just write the plain hash is because that's the same
syntax as the fih accepts in its input. This way you can do:
  $ ( cat marks; cat fast-export-stream ) | git fast-import-helper >> marks
and can restart at any time. Also, making the output a bit more
structured allows it to be easily extended in the future.

tom
