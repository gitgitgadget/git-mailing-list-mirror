From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH v2 3/8] diff-delta.c: "delta.h" is not a required include
Date: Fri, 05 Jun 2009 21:49:38 -0500
Message-ID: <P6YSWMs6FWplIDEFHZcRIeF7G1bOeRomvBYwfaQf2dgnsOWGC2AaBg@cipher.nrlssc.navy.mil>
References: <67hZHClrEWQHxCRdWosE24FbCSWPktK230jx86LzLj0Aqa5g5XoJb3Iv805pzfx5wCPameuSp6M@cipher.nrlssc.navy.mil> <M3MzU6FlQXfVApDnN0vdEf4UcS0v8Dh-XOz1cA15MA7nN8wUHrIif6F7g1-JWcHSJSi5Z6_vOoA@cipher.nrlssc.navy.mil> <alpine.LFD.2.00.0906052112590.3906@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, peff@peff.net,
	Brandon Casey <drafnel@gmail.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Jun 06 04:51:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCm0H-0000jg-Do
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 04:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753117AbZFFCt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 22:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753058AbZFFCtz
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 22:49:55 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:46282 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992AbZFFCty (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 22:49:54 -0400
Received: by mail.nrlssc.navy.mil id n562ndqm011984; Fri, 5 Jun 2009 21:49:39 -0500
In-Reply-To: <alpine.LFD.2.00.0906052112590.3906@xanadu.home>
X-OriginalArrivalTime: 06 Jun 2009 02:49:39.0266 (UTC) FILETIME=[6F68FA20:01C9E651]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120863>

Nicolas Pitre wrote:
> On Fri, 5 Jun 2009, Brandon Casey wrote:
> 
>> From: Brandon Casey <drafnel@gmail.com>
>>
>> When compiling diff-delta.c with the SUNWspro C99 compiler, it complains
>>
>>     "diff-delta.c", line 314: identifier redeclared: create_delta
>>
>> There is nothing in "delta.h" that is required by diff-delta.c, so don't
>> include it.
>>
>> Signed-off-by: Brandon Casey <drafnel@gmail.com>
> 
> NAK.
> 
> This is common practice to include the header file declaring function 
> prototypes into the file defining the actual function so to make sure 
> the declaration matches with the definition.  Deleting that include is 
> actively ignoring a problem instead of fixing the cause of it.


It doesn't seem to like the structure being redeclared with a flex array
member and being passed as a const argument.


# cat > test.c <<EOF

struct a_struct;

extern void *test_func(const struct a_struct *f);

struct a_struct {
        int a;
        int b;
        char* c[];
};

void *test_func(const struct a_struct *f)
{
        return 0;
}
EOF

# /opt/SUNWspro/bin/c99 -c test.c 
"test.c", line 13: identifier redeclared: test_func
        current : function(pointer to const struct a_struct {int a, int b, array[-1] of pointer to char c}) returning pointer to void
        previous: function(pointer to const struct a_struct {int a, int b, array[-1] of pointer to char c}) returning pointer to void : "test.c", line 4
c99: acomp failed for test.c


If either the flex array is removed from the structure, or const is removed from
test_func argument, test.c will compile.  Compiling with -O0 doesn't help.

-brandon
