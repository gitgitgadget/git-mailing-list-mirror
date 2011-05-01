From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH] lookup_object(): Speed up 'git gc' by 12%, by reducing
 hash chain length
Date: Sun, 01 May 2011 16:21:40 +0300
Message-ID: <4DBD5E64.507@redhat.com>
References: <20110427213502.GA13647@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Sun May 01 15:22:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGWb0-0000TH-M3
	for gcvg-git-2@lo.gmane.org; Sun, 01 May 2011 15:21:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754674Ab1EANVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2011 09:21:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64259 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751293Ab1EANVu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2011 09:21:50 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p41DLkVL022309
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sun, 1 May 2011 09:21:46 -0400
Received: from balrog.tlv.redhat.com (dhcp-1-27.tlv.redhat.com [10.35.1.27])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p41DLfXc006204
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Sun, 1 May 2011 09:21:44 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110421 Fedora/3.1.9-2.fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <20110427213502.GA13647@elte.hu>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172538>

On 04/28/2011 12:35 AM, Ingo Molnar wrote:
>           :              while ((obj = obj_hash[i]) != NULL) {
>      4.13 :        498316:       eb 1f                   jmp    498337<lookup_object+0x47>
>      0.00 :        498318:       0f 1f 84 00 00 00 00    nopl   0x0(%rax,%rax,1)
>      0.00 :        49831f:       00
>           :                      if (!hashcmp(sha1, obj->sha1))
>      1.48 :        498320:       48 8d 78 04             lea    0x4(%rax),%rdi
>      0.02 :        498324:       4c 89 d6                mov    %r10,%rsi
>      0.00 :        498327:       4c 89 d9                mov    %r11,%rcx
>     26.12 :        49832a:       f3 a6                   repz cmpsb %es:(%rdi),%ds:(%rsi)
>     17.12 :        49832c:       74 14                   je     498342<lookup_object+0x52>
>           :                              break;

rep cmps can be very slow on some machines, and in particular, rep cmpsb 
is optimized for really small strings (the tail of a larger rep cmps[lq] 
run).

I think that if you'll replace hashcmp() by something like

static inline bool hashcmp(const unsigned char *sha1, const unsigned 
char *sha2)
{
      unsigned long cmp;

      cmp = *(uint64_t *)sha1 ^ *(unint64_t *)sha2;
      cmp |= *(uint64_t *)(sha1 + 8) ^ *(unint64_t *)(sha2 + 8);
      cmp |= *(uint32_t *)(sha1 + 16) ^ *(unint32_t *)(sha2 + 16);
      return cmp == 0;
}

You'll see much better results.

Of course this only works in general if the hashes are aligned.

-- 
error compiling committee.c: too many arguments to function
